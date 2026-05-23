import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:technical_test_propnext/core/error/failures.dart';
import 'package:technical_test_propnext/core/utils/api_error_handler.dart';
import 'package:technical_test_propnext/data/datasources/product_remote_datasources.dart';
import 'package:technical_test_propnext/domain/entities/product.dart';
import 'package:technical_test_propnext/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Product>>> getProducts({
    int limit = 10,
    int skip = 0,
  }) async {
    try {
      final result = await remoteDataSource.getProducts(
        limit: limit,
        skip: skip,
      );
      return Right(result.products);
    } on http.Response catch (response) {
      final errorMessage = ApiErrorHandler.mapError(response);
      return Left(ServerFailure(errorMessage));
    } catch (e) {
      final errorMessage = ApiErrorHandler.mapException(e);
      return Left(ConnectionFailure(errorMessage));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> searchProducts(
    String query, {
    int limit = 10,
    int skip = 0,
  }) async {
    try {
      final result = await remoteDataSource.searchProducts(
        query,
        limit: limit,
        skip: skip,
      );
      return Right(result.products);
    } on http.Response catch (response) {
      final errorMessage = ApiErrorHandler.mapError(response);
      return Left(ServerFailure(errorMessage));
    } catch (e) {
      final errorMessage = ApiErrorHandler.mapException(e);
      return Left(ConnectionFailure(errorMessage));
    }
  }

  @override
  Future<Either<Failure, Product>> getProductDetail(int id) async {
    try {
      final result = await remoteDataSource.getProductDetail(id);
      return Right(result);
    } on http.Response catch (response) {
      final errorMessage = ApiErrorHandler.mapError(response);
      return Left(ServerFailure(errorMessage));
    } catch (e) {
      final errorMessage = ApiErrorHandler.mapException(e);
      return Left(ConnectionFailure(errorMessage));
    }
  }

  @override
  Future<Either<Failure, Product>> addProduct({
    required String title,
    required String description,
    required double price,
    required int stock,
    required String category,
    required String thumbnail,
  }) async {
    try {
      final result = await remoteDataSource.addProduct(
        title: title,
        description: description,
        price: price,
        stock: stock,
        category: category,
        thumbnail: thumbnail,
      );
      return Right(result);
    } on http.Response catch (response) {
      final errorMessage = ApiErrorHandler.mapError(response);
      return Left(ServerFailure(errorMessage));
    } catch (e) {
      final errorMessage = ApiErrorHandler.mapException(e);
      return Left(ConnectionFailure(errorMessage));
    }
  }

  @override
  Future<Either<Failure, Product>> updateProduct({
    required int id,
    required String title,
    required String description,
    required double price,
    required int stock,
    required String category,
    required String thumbnail,
  }) async {
    // DummyJSON database has exactly 100 products (IDs 1-100).
    // Any ID > 100 is a locally created product mock, so we return it locally.
    if (id > 100) {
      return Right(
        Product(
          id: id,
          title: title,
          description: description,
          price: price,
          stock: stock,
          category: category,
          thumbnail: thumbnail,
          images: [thumbnail],
        ),
      );
    }
    try {
      final result = await remoteDataSource.updateProduct(
        id: id,
        title: title,
        description: description,
        price: price,
        stock: stock,
        category: category,
        thumbnail: thumbnail,
      );
      return Right(result);
    } on http.Response catch (response) {
      final errorMessage = ApiErrorHandler.mapError(response);
      return Left(ServerFailure(errorMessage));
    } catch (e) {
      final errorMessage = ApiErrorHandler.mapException(e);
      return Left(ConnectionFailure(errorMessage));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteProduct(int id) async {
    if (id > 100) {
      return const Right(unit);
    }
    try {
      await remoteDataSource.deleteProduct(id);
      return const Right(unit);
    } on http.Response catch (response) {
      final errorMessage = ApiErrorHandler.mapError(response);
      return Left(ServerFailure(errorMessage));
    } catch (e) {
      final errorMessage = ApiErrorHandler.mapException(e);
      return Left(ConnectionFailure(errorMessage));
    }
  }
}
