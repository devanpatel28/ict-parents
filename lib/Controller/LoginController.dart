import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../API/API.dart';
import '../Model/UserDataModel.dart';

class LoginController extends GetxController {
  final box = GetStorage();

  Future<bool> login(String username, String password) async {
    try {
      Map<String, String> body = {
        'username': username,
        'password': password
      };
      final response = await http.post(
        Uri.parse(validateLoginAPI),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        UserData userData = UserData.fromJson(responseData);

        box.write('userdata', userData.toJson());
        box.write('loggedin', true);

        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}
