import 'package:get/get.dart';

import '../../modules/dashboard/dashboard_controller.dart';
import '../../modules/dashboard/dashboard_view.dart';
import '../../modules/login/login_binding.dart';
import '../../modules/login/login_view.dart';
import '../../modules/users/user_binding.dart';
import '../../modules/users/user_list_view.dart';
import '../../modules/features/feature_binding.dart';
import '../../modules/features/feature_list_view.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),

    // DASHBOARD SHELL
    GetPage(
      name: AppRoutes.DASHBOARD,
      page: () => const DashboardView(),
      binding: BindingsBuilder(() {
        Get.put(DashboardController());
      }),
    ),

    // DASHBOARD CONTENT ROUTES
    GetPage(
      name: AppRoutes.USERS,
      page: () => UserListView(),
      binding: UserBinding(),
    ),

    // GetPage(
    //   name: AppRoutes.ROLES,
    //   page: () => const RoleListView(),
    // ),

    GetPage(
      name: AppRoutes.FEATURES,
      page: () => const FeatureListView(),
      binding: FeatureBinding(),
    ),
  ];
}
