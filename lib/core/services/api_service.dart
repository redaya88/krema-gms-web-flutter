import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // static const String baseUrl = "http://localhost:3000";
  static const String baseUrl = "https://probable-fiesta-69qvp5gq6jvxh5p97-3000.app.github.dev/";

  Future<dynamic> post(String path, Map body) async {
    final url = Uri.parse("$baseUrl$path");

    final response = await http.post(
      url,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );

    return jsonDecode(response.body);
  }

  Future<dynamic> get(String path) async {
    final url = Uri.parse("$baseUrl$path");
    final response = await http.get(url);

    return jsonDecode(response.body);
  }
}
