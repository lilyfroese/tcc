import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:tcc/core/api/http_client.dart';

class Api {
  static late HttpClient client;

  static void init() {
    String baseUrl;

    if (kIsWeb) {
      baseUrl = "http://localhost:3333";
    } else {
      baseUrl = "http://10.0.2.2:3333";
    }

    client = HttpClient(baseUrl);
  }
}
