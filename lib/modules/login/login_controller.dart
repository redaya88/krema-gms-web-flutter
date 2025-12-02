import 'package:get/get.dart';
import '../../core/services/auth_service.dart';
// import 'login_view.dart';

class LoginController extends GetxController {
  var username = ''.obs;
  var password = ''.obs;
  var isLoading = false.obs;

  final AuthService _authService = Get.find<AuthService>();

  /// Call this when login button is pressed
  Future<void> login() async {
    if (username.value.isEmpty || password.value.isEmpty) {
      Get.snackbar('Error', 'Username and password cannot be empty');
      return;
    }

    isLoading.value = true;

    final success = await _authService.login(username.value, password.value);

    isLoading.value = false;

    if (success) {
      // Navigate to dashboard
      Get.offAllNamed('/dashboard');
    } else {
      Get.snackbar('Error', 'Invalid username or password');
    }
  }
}
