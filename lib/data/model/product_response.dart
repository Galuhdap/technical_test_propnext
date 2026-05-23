import 'package:technical_test_propnext/domain/entities/product.dart';

class ProductResponse {
  final List<ProductModel> products;
  final int total;
  final int skip;
  final int limit;

  ProductResponse({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    final productsList = json['products'] != null
        ? List<ProductModel>.from(
            (json['products'] as List).map(
              (item) => ProductModel.fromJson(item),
            ),
          )
        : <ProductModel>[];

    return ProductResponse(
      products: productsList,
      total: json['total'] ?? 0,
      skip: json['skip'] ?? 0,
      limit: json['limit'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'products': products.map((item) => item.toJson()).toList(),
      'total': total,
      'skip': skip,
      'limit': limit,
    };
  }
}

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.title,
    required super.description,
    required super.price,
    required super.stock,
    required super.category,
    required super.thumbnail,
    required super.images,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final imagesList = json['images'] != null
        ? List<String>.from(json['images'].map((item) => item.toString()))
        : <String>[];

    return ProductModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] != null ? (json['price'] as num).toDouble() : 0.0,
      stock: json['stock'] ?? 0,
      category: json['category'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      images: imagesList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'stock': stock,
      'category': category,
      'thumbnail': thumbnail,
      'images': images,
    };
  }

  factory ProductModel.fromEntity(Product product) {
    return ProductModel(
      id: product.id,
      title: product.title,
      description: product.description,
      price: product.price,
      stock: product.stock,
      category: product.category,
      thumbnail: product.thumbnail,
      images: product.images,
    );
  }
}
