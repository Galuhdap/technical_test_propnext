import 'package:flutter/material.dart';
import 'package:technical_test_propnext/domain/entities/product.dart';
import 'package:technical_test_propnext/domain/repositories/product_repository.dart';

class ProductProvider extends ChangeNotifier {
  final ProductRepository repository;

  ProductProvider({required this.repository});

  final List<Product> _products = [];
  List<Product> get products => List.unmodifiable(_products);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isLoadingMore = false;
  bool get isLoadingMore => _isLoadingMore;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  int _skip = 0;
  final int _limit = 10;
  bool _hasMore = true;
  bool get hasMore => _hasMore;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  bool _isSubmitting = false;
  bool get isSubmitting => _isSubmitting;

  String? _submitError;
  String? get submitError => _submitError;

  Future<void> loadProducts({bool refresh = false}) async {
    if (_isLoading || _isLoadingMore || (!_hasMore && !refresh)) return;

    if (refresh) {
      _products.clear();
      _skip = 0;
      _hasMore = true;
      _errorMessage = null;
    }

    if (_skip == 0) {
      _isLoading = true;
    } else {
      _isLoadingMore = true;
    }
    notifyListeners();

    final result = _searchQuery.trim().isNotEmpty
        ? await repository.searchProducts(
            _searchQuery,
            limit: _limit,
            skip: _skip,
          )
        : await repository.getProducts(limit: _limit, skip: _skip);

    result.fold(
      (failure) {
        _errorMessage = failure.message;
        _isLoading = false;
        _isLoadingMore = false;
        notifyListeners();
      },
      (newProducts) {
        if (newProducts.length < _limit) {
          _hasMore = false;
        }
        _products.addAll(newProducts);
        _skip += newProducts.length;

        _isLoading = false;
        _isLoadingMore = false;
        _errorMessage = null;
        notifyListeners();
      },
    );
  }

  Future<void> search(String query) async {
    if (_searchQuery == query) return;
    _searchQuery = query;

    await loadProducts(refresh: true);
  }

  Future<void> clearSearch() async {
    if (_searchQuery.isEmpty) return;
    _searchQuery = '';
    await loadProducts(refresh: true);
  }

  Future<bool> createProduct({
    required String title,
    required String description,
    required double price,
    required int stock,
    required String category,
    required String thumbnail,
  }) async {
    _isSubmitting = true;
    _submitError = null;
    notifyListeners();

    final result = await repository.addProduct(
      title: title,
      description: description,
      price: price,
      stock: stock,
      category: category,
      thumbnail: thumbnail,
    );

    return result.fold(
      (failure) {
        _submitError = failure.message;
        _isSubmitting = false;
        notifyListeners();
        return false;
      },
      (newProduct) {
        _products.insert(0, newProduct);
        _isSubmitting = false;
        _errorMessage = null;
        notifyListeners();
        return true;
      },
    );
  }

  Future<bool> editProduct({
    required int id,
    required String title,
    required String description,
    required double price,
    required int stock,
    required String category,
    required String thumbnail,
  }) async {
    _isSubmitting = true;
    _submitError = null;
    notifyListeners();

    final result = await repository.updateProduct(
      id: id,
      title: title,
      description: description,
      price: price,
      stock: stock,
      category: category,
      thumbnail: thumbnail,
    );

    return result.fold(
      (failure) {
        _submitError = failure.message;
        _isSubmitting = false;
        notifyListeners();
        return false;
      },
      (updatedProduct) {
        final index = _products.indexWhere((p) => p.id == id);
        if (index != -1) {
          _products[index] = updatedProduct;
        }
        _isSubmitting = false;
        _errorMessage = null;
        notifyListeners();
        return true;
      },
    );
  }

  Future<bool> removeProduct(int id) async {
    final result = await repository.deleteProduct(id);

    return result.fold(
      (failure) {
        return false;
      },
      (_) {
        _products.removeWhere((p) => p.id == id);
        notifyListeners();
        return true;
      },
    );
  }
}
