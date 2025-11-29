import '../core/api/api.dart';
import '../core/api/api_response.dart';
import '../core/api/auth_storage.dart';

class MetaService {
  final AuthStorage storage = AuthStorage();

  Future<ApiResponse> getMetas() async {
    final token = await storage.getToken();

    final res = await Api.client.get(
      '/metas',
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    return res;
  }

  Future<ApiResponse> criarMeta(Map<String, dynamic> data) async {
    final token = await storage.getToken();

    final res = await Api.client.post(
      '/metas',
      data,
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    return res;
  }
}
