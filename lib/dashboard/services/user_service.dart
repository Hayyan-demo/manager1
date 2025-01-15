import 'dart:convert';

import 'package:order_delivery_manager/core/constants/strings.dart';
import 'package:order_delivery_manager/core/util/variables/global_variables.dart';
import 'package:http/http.dart' as http;
import 'package:order_delivery_manager/dashboard/models/user_model.dart';

class UserService {
  Map<String, String> get _headers => {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

  Future<int> getUserCount() async {
    final response = await http.get(Uri.parse('$BASE_URL_WEB/user-count'),
        headers: _headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['user_count'];
    } else {
      throw Exception('Failed to load user count');
    }
  }

  Future<int> getDriverCount() async {
    final response = await http.get(Uri.parse('$BASE_URL_WEB/user-count'),
        headers: _headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['driver_count'];
    } else {
      throw Exception('Failed to load user count');
    }
  }

  Future<List<UserModel>> getUsers() async {
    final response =
        await http.get(Uri.parse('$BASE_URL_WEB/users'), headers: _headers);
    if (response.statusCode == 200) {
      final List<dynamic> userList = jsonDecode(response.body);
      return userList.map((userJson) => UserModel.fromJson(userJson)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}
