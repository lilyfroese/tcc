import 'dart:convert';
import '../core/api/api.dart';
import '../core/api/api_response.dart';
import '../core/api/auth_storage.dart';

class AuthService {
  final AuthStorage storage = AuthStorage();

  Future<bool> cadastrar({
  required String nome,
  required String email,
  required String senha,
  required String grupo,
  }) async {
    final response = await Api.client.post(
      "/users",
      {
        "username": nome,
        "email": email,
        "grupo": grupo,
        "password": senha,
      },
    );

    return response.ok;
  }


  Future<bool> login({
  required String nome,
  required String email,
  required String senha,
  }) async {
    final response = await Api.client.post(
      "/login",
      {
        "username": nome,
        "email": email,
        "password": senha,
      },
    );

    if (!response.ok) {
      return false;
    }

    final data = response.data;

    final token = data["token"];
    final refreshToken = data["refresh_token"];


    await storage.saveTokens(
      token: token,
      refreshToken: refreshToken,
    );

    return true;
  }

  Future<void> logout() async {
    await storage.clear();
  }
}
