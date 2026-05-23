import 'package:dartz/dartz.dart';
import 'package:technical_test_propnext/core/error/failures.dart';
import 'package:technical_test_propnext/domain/entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts({
    int limit = 10,
    int skip = 0,
  });

  Future<Either<Failure, List<Product>>> searchProducts(
    String query, {
    int limit = 10,
    int skip = 0,
  });

  Future<Either<Failure, Product>> getProductDetail(int id);

  Future<Either<Failure, Product>> addProduct({
    required String title,
    required String description,
    required double price,
    required int stock,
    required String category,
    required String thumbnail,
  });

  Future<Either<Failure, Product>> updateProduct({
    required int id,
    required String title,
    required String description,
    required double price,
    required int stock,
    required String category,
    required String thumbnail,
  });

  Future<Either<Failure, Unit>> deleteProduct(int id);
}
