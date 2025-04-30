import 'dart:convert';
import '../widgets/config.dart';
import 'common_service/api_service.dart';


class LoginService {
  static final LoginService _instance = LoginService._internal();

  factory LoginService() => _instance;

  LoginService._internal();

  Future<dynamic> loginList() async {
    final response = await ApiService().getData(AppConfig.loginUrl);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('GET request failed: ${response.statusCode}');
    }
  }

  static Future<dynamic> loginPostMethod(Map<String, dynamic> data) async {
    final response = await ApiService().postData(AppConfig.loginUrl, data);
    if (response.statusCode == 200) {

      return response.body;
    } else {
      throw response.message.toString();
    }
  }
}
