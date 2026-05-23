import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:technical_test_propnext/config/flavor_config.dart';
import 'package:technical_test_propnext/core/utils/api_logger.dart';
import 'package:technical_test_propnext/data/model/product_response.dart';

abstract class ProductRemoteDataSource {
  Future<ProductResponse> getProducts({int limit = 10, int skip = 0});
  Future<ProductResponse> searchProducts(
    String query, {
    int limit = 10,
    int skip = 0,
  });
  Future<ProductModel> getProductDetail(int id);

  Future<ProductModel> addProduct({
    required String title,
    required String description,
    required double price,
    required int stock,
    required String category,
    required String thumbnail,
  });

  Future<ProductModel> updateProduct({
    required int id,
    required String title,
    required String description,
    required double price,
    required int stock,
    required String category,
    required String thumbnail,
  });

  Future<void> deleteProduct(int id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;
  final baseUrl = FlavorConfig.instance.baseUrl;

  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<ProductResponse> getProducts({int limit = 10, int skip = 0}) async {
    final url = '$baseUrl/products?limit=$limit&skip=$skip';

    ApiLogger.logRequest(url: url, method: 'GET');

    try {
      final response = await client.get(Uri.parse(url));

      ApiLogger.logResponse(
        url: url,
        statusCode: response.statusCode,
        responseBody: response.body,
      );

      if (response.statusCode == 200) {
        return ProductResponse.fromJson(jsonDecode(response.body));
      } else {
        throw http.Response(response.body, response.statusCode);
      }
    } catch (e) {
      if (e is http.Response) rethrow;
      throw Exception(e.toString());
    }
  }

  @override
  Future<ProductResponse> searchProducts(
    String query, {
    int limit = 10,
    int skip = 0,
  }) async {
    final encodedQuery = Uri.encodeComponent(query);
    final url =
        '$baseUrl/products/search?q=$encodedQuery&limit=$limit&skip=$skip';

    ApiLogger.logRequest(url: url, method: 'GET');

    try {
      final response = await client.get(Uri.parse(url));

      ApiLogger.logResponse(
        url: url,
        statusCode: response.statusCode,
        responseBody: response.body,
      );

      if (response.statusCode == 200) {
        return ProductResponse.fromJson(jsonDecode(response.body));
      } else {
        throw http.Response(response.body, response.statusCode);
      }
    } catch (e) {
      if (e is http.Response) rethrow;
      throw Exception(e.toString());
    }
  }

  @override
  Future<ProductModel> getProductDetail(int id) async {
    final url = '$baseUrl/products/$id';

    ApiLogger.logRequest(url: url, method: 'GET');

    try {
      final response = await client.get(Uri.parse(url));

      ApiLogger.logResponse(
        url: url,
        statusCode: response.statusCode,
        responseBody: response.body,
      );

      if (response.statusCode == 200) {
        return ProductModel.fromJson(jsonDecode(response.body));
      } else {
        throw http.Response(response.body, response.statusCode);
      }
    } catch (e) {
      if (e is http.Response) rethrow;
      throw Exception(e.toString());
    }
  }

  @override
  Future<ProductModel> addProduct({
    required String title,
    required String description,
    required double price,
    required int stock,
    required String category,
    required String thumbnail,
  }) async {
    final url = '$baseUrl/products/add';
    final body = {
      'title': title,
      'description': description,
      'price': price,
      'stock': stock,
      'category': category,
      'thumbnail': thumbnail,
    };
    final headers = {'Content-Type': 'application/json'};

    ApiLogger.logRequest(
      url: url,
      method: 'POST',
      headers: headers,
      body: body,
    );

    try {
      final response = await client.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );

      ApiLogger.logResponse(
        url: url,
        statusCode: response.statusCode,
        responseBody: response.body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ProductModel.fromJson(jsonDecode(response.body));
      } else {
        throw http.Response(response.body, response.statusCode);
      }
    } catch (e) {
      if (e is http.Response) rethrow;
      throw Exception(e.toString());
    }
  }

  @override
  Future<ProductModel> updateProduct({
    required int id,
    required String title,
    required String description,
    required double price,
    required int stock,
    required String category,
    required String thumbnail,
  }) async {
    final url = '$baseUrl/products/$id';
    final body = {
      'title': title,
      'description': description,
      'price': price,
      'stock': stock,
      'category': category,
      'thumbnail': thumbnail,
    };
    final headers = {'Content-Type': 'application/json'};

    ApiLogger.logRequest(url: url, method: 'PUT', headers: headers, body: body);

    try {
      final response = await client.put(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );

      ApiLogger.logResponse(
        url: url,
        statusCode: response.statusCode,
        responseBody: response.body,
      );

      if (response.statusCode == 200) {
        return ProductModel.fromJson(jsonDecode(response.body));
      } else {
        throw http.Response(response.body, response.statusCode);
      }
    } catch (e) {
      if (e is http.Response) rethrow;
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> deleteProduct(int id) async {
    final url = '$baseUrl/products/$id';

    ApiLogger.logRequest(url: url, method: 'DELETE');

    try {
      final response = await client.delete(Uri.parse(url));

      ApiLogger.logResponse(
        url: url,
        statusCode: response.statusCode,
        responseBody: response.body,
      );

      if (response.statusCode == 200) {
        return;
      } else {
        throw http.Response(response.body, response.statusCode);
      }
    } catch (e) {
      if (e is http.Response) rethrow;
      throw Exception(e.toString());
    }
  }
}
