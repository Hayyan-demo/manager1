import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:order_delivery_manager/core/constants/strings.dart';
import 'package:order_delivery_manager/core/util/variables/global_variables.dart';
import 'package:order_delivery_manager/dashboard/models/product_model.dart';

class ProductService {
  Map<String, String> get _headers => {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

  // Retrieve a list of products with optional search and store ID filter
  Future<List<ProductModel>> getProducts({int page = 1}) async {
    try {
      final queryParams = {
        'page': page.toString(),
      };

      final response = await http.get(
        Uri.parse(BASE_URL_WEB).replace(queryParameters: queryParams),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return (data['products']['data'] as List)
            .map((json) => ProductModel.fromJson(json))
            .toList();
      } else {
        throw Exception(
            'Failed to retrieve products: ${jsonDecode(response.body)['message']}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> createProduct(
      Map<String, dynamic> body, List<Uint8List> pictures) async {
    const String productsLink = '$BASE_URL_WEB/products';

    try {
      // First request for the body
      final bodyResponse = await http.post(
        Uri.parse(productsLink),
        headers: _headers,
        body: jsonEncode(body),
      );

      if (bodyResponse.statusCode == 200) {
        final productId = jsonDecode(bodyResponse.body)['product']['id'];
        final String imagesLink =
            '$BASE_URL_WEB/products/$productId/images'; // Adjust this URL as needed
        // Second request for the pictures
        for (var i = 0; i < pictures.length; i++) {
          var pictureRequest = http.MultipartRequest(
            'POST',
            Uri.parse(imagesLink),
          );

          // Adding headers
          pictureRequest.headers.addAll(_headers);

          // Adding pictures as files
          pictureRequest.files.add(http.MultipartFile.fromBytes(
            'image', // The field name should match the one expected by your backend
            pictures[i],
            filename: 'picture_$i.jpg',
          ));
          final pictureResponse = await pictureRequest.send();

          if (pictureResponse.statusCode == 201) {
            // 201 for successful creation
            continue;
          } else {
            final responseBody = await pictureResponse.stream.bytesToString();
            throw Exception(
                'Failed to add pictures: ${jsonDecode(responseBody)['message']}');
          }
        }
        return;
      } else {
        throw Exception(
            'Failed to add product: ${jsonDecode(bodyResponse.body)['message']}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Function to get the total number of products
  Future<int> getProductCount() async {
    final response = await http.get(Uri.parse('$BASE_URL_WEB/product-count'),
        headers: _headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['product_count'];
    } else {
      throw Exception('Failed to load product count');
    }
  }

  // Delete a specific product by ID
  Future<void> deleteProduct(String id) async {
    try {
      final response = await http.delete(
        Uri.parse('$BASE_URL_WEB/products/$id'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception(
            'Failed to delete product: ${jsonDecode(response.body)['message']}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Search for products by name or description
  Future<List<ProductModel>> searchProducts(String searchQuery,
      {int page = 1}) async {
    try {
      final queryParams = {
        'search': searchQuery,
        'page': page.toString(),
      };

      final response = await http.get(
        Uri.parse("$BASE_URL_WEB/products")
            .replace(queryParameters: queryParams),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return (data['products']['data'] as List)
            .map((json) => ProductModel.fromJson(json))
            .toList();
      } else {
        throw Exception(
            'Failed to search products: ${jsonDecode(response.body)['message']}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
