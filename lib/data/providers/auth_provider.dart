import 'package:get/get.dart';
import 'package:krema_gms_web/core/services/auth_service.dart';
import 'package:krema_gms_web/core/services/storage_service.dart';

class AuthProvider extends GetConnect {
  static AuthProvider get instance => Get.find<AuthProvider>();

  @override
  void onInit() {
    httpClient.baseUrl =
        "https://ominous-space-lamp-7v67x596q647fxqjv-3000.app.github.dev";
    httpClient.timeout = const Duration(seconds: 15);

    /// Attach access token automatically
    httpClient.addRequestModifier<dynamic>((request) {
      final storage = Get.find<StorageService>();
      final token = storage.accessToken;

      if (token != null && token.isNotEmpty) {
        request.headers['Authorization'] = 'Bearer $token';
      }
      return request;
    });

    /// 🔹 Global response handler (401 = logout)
    httpClient.addResponseModifier((request, response) {
      if (response.statusCode == 401) {
        if (Get.isRegistered<AuthService>()) {
          Get.find<AuthService>().logout();
        }
        Get.offAllNamed('/login');
      }
      return response;
    });

    super.onInit();
  }

  Future<Response> login(String username, String password) {
    return post("/auth/login", {
      "username": username,
      "password": password,
    });
  }

  Future<Response> getUsers() => get("/users");
}
