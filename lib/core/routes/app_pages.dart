import 'package:get/get.dart';

import '../../modules/dashboard/dashboard_controller.dart';
import '../../modules/dashboard/dashboard_view.dart';
import '../../modules/login/login_binding.dart';
import '../../modules/login/login_view.dart';
import '../../modules/users/user_binding.dart';
import '../../modules/users/user_list_view.dart';
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
