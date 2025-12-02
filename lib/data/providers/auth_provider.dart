import 'package:get/get.dart';

class AuthProvider extends GetConnect {
  /// Singleton instance
  static AuthProvider get instance => Get.find<AuthProvider>();

  @override
  void onInit() {
    httpClient.baseUrl = "http://localhost:3000"; // your backend API
    httpClient.timeout = const Duration(seconds: 15);
    super.onInit();
  }

  /// Login request
  Future<Response> login(String username, String password) {
    return post("/auth/login", {"username": username, "password": password});
  }

  /// Example: other endpoints
  Future<Response> getUsers() => get("/users");
}
