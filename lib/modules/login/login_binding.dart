import 'package:get/get.dart';
import '../../data/providers/auth_provider.dart';
import 'login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthProvider());
    Get.put(LoginController());
  }
}
