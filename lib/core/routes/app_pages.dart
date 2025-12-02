import 'package:get/get.dart';

import '../../module/dashboard/dashboard_controller.dart';
import '../../module/dashboard/dashboard_view.dart';
import '../../module/login/login_binding.dart';
import '../../module/login/login_view.dart';
import '../../module/users/user_binding.dart';
import '../../module/users/user_list_view.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.DASHBOARD,
      page: () => DashboardView(),
      binding: BindingsBuilder(() {
        Get.put(DashboardController());
      }),
    ),
    GetPage(
      name: AppRoutes.USERS,
      page: () => UserListView(),
      binding: UserBinding(),
    ),
  ];
}
