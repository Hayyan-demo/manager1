import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:order_delivery_manager/core/constants/strings.dart';
import 'package:order_delivery_manager/core/util/variables/global_variables.dart';

class AuthService {
  // Function to log in a user
  Future<void> login(String phone, String password) async {
    var uri = Uri.parse('$BASE_URL_WEB/login');
    var response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'phone': phone, 'password': password}),
    );

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      token = jsonResponse['user']['token'];
    } else {
      throw Exception('Failed to login');
    }
  }

  // Function to log out a user
  Future<void> logout() async {
    var uri = Uri.parse('$BASE_URL_WEB/logout');
    var response = await http.post(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      token = '';
    } else {
      throw Exception('Failed to logout');
    }
  }
}
