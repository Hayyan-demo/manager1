import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:order_delivery_manager/core/constants/strings.dart';
import 'package:order_delivery_manager/core/util/variables/global_variables.dart';
import 'dart:convert';

import 'package:order_delivery_manager/dashboard/models/store_module.dart';

class StoreService {
  // Function to add a new store
  Future<void> addStore(String name, {Uint8List? logoData}) async {
    var uri = Uri.parse('$BASE_URL_WEB/stores');
    var request = http.MultipartRequest('POST', uri)
      ..fields['name'] = name
      ..headers.addAll(_headers);

    if (logoData != null) {
      var multipartFile = http.MultipartFile.fromBytes(
        'logo',
        logoData,
        filename: 'logo.png', // Provide a filename for the uploaded image
      );
      request.files.add(multipartFile);
    }

    var response = await request.send();

    if (response.statusCode == 201) {
      return;
    } else {
      throw Exception('Failed to add store');
    }
  }

  // Function to get the total number of stores
  Future<int> getStoreCount() async {
    final response = await http.get(Uri.parse('$BASE_URL_WEB/store-count'),
        headers: _headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['store_count'];
    } else {
      throw Exception('Failed to load store count');
    }
  }

  // Function to delete a store
  Future<void> deleteStore(String id) async {
    var uri = Uri.parse('$BASE_URL_WEB/stores/$id');
    var response = await http.delete(uri, headers: _headers);

    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed to delete store');
    }
  }

  // Function to search for a store
  Future<List<StoreModel>> searchStore(String searchTerm) async {
    var uri = Uri.parse('$BASE_URL_WEB/stores?search=$searchTerm');
    var response = await http.get(uri, headers: _headers);

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var stores = List<Map<String, dynamic>>.from(jsonResponse['stores']);
      return stores.map((storeJson) => StoreModel.fromJson(storeJson)).toList();
    } else {
      throw Exception('Failed to search stores');
    }
  }

  //Function to get total profit
  Future<double> getTotalProfit() async {
    try {
      final response = await http.get(Uri.parse("$BASE_URL_WEB/total-profit"),
          headers: _headers);

      if (response.statusCode == 200) {
        return jsonDecode(response.body)['total_profit'];
      } else {
        throw Exception('Failed to search stores');
      }
    } catch (e) {
      throw Exception('Something went wrong while fetching total profit: $e');
    }
  }

  Map<String, String> get _headers => {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };
}
