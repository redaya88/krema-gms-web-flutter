import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/routes/app_routes.dart';
import '../../core/widgets/sidebar/app_sidebar.dart';
import '../../core/services/auth_service.dart';
import '../../data/models/feature_model.dart';

// TOP BAR
import 'dashboard_topbar.dart';

// USERS
import '../../modules/users/user_list_view.dart';
import '../../modules/users/user_binding.dart';

// FEATURES
import '../../modules/features/feature_list_view.dart';
import '../../modules/features/feature_binding.dart';

// ROLES (optional)
// import '../../modules/roles/role_list_view.dart';
// import '../../modules/roles/role_binding.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final AuthService authService = Get.find<AuthService>();

  bool isSidebarExpanded = true;
  int selectedMenuIndex = 0;
  String selectedProfileOption = 'Profile';

  bool get isMobile => MediaQuery.of(context).size.width < 800;

  @override
  void initState() {
    super.initState();
    _syncMenuWithRoute();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,

      // ───────── MOBILE DRAWER ─────────
      drawer: isMobile
          ? Drawer(
              child: AppSidebar(
                expanded: true,
                selectedIndex: selectedMenuIndex,
                onToggle: () {},
                onMenuSelected: _onMenuSelected,
              ),
            )
          : null,

      body: Row(
        children: [
          // ───────── DESKTOP SIDEBAR ─────────
          if (!isMobile)
            AppSidebar(
              expanded: isSidebarExpanded,
              selectedIndex: selectedMenuIndex,
              onToggle: () =>
                  setState(() => isSidebarExpanded = !isSidebarExpanded),
              onMenuSelected: _onMenuSelected,
            ),

          // ───────── MAIN CONTENT ─────────
          Expanded(
            child: Column(
              children: [
                // ───────── TOP BAR ─────────
                DashboardTopBar(
                  isMobile: isMobile,
                  isSidebarExpanded: isSidebarExpanded,
                  selectedProfileOption: selectedProfileOption,
                  scaffoldKey: _scaffoldKey,
                  onToggleSidebar: () =>
                      setState(() => isSidebarExpanded = !isSidebarExpanded),
                  onSelectProfileOption: _onProfileSelected,
                ),

                // ───────── PAGE CONTENT (NESTED) ─────────
                Expanded(
                  child: Navigator(
                    key: Get.nestedKey(1),
                    initialRoute: AppRoutes.FEATURES,
                    onGenerateRoute: _onGenerateRoute,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────
  // NESTED ROUTING WITH BINDINGS
  // ─────────────────────────────────────
  Route _onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.USERS:
        return GetPageRoute(
          settings: settings,
          page: () => UserListView(),
          binding: UserBinding(),
        );

      case AppRoutes.FEATURES:
      default:
        return GetPageRoute(
          settings: settings,
          page: () => const FeatureListView(),
          binding: FeatureBinding(),
        );
    }
  }

  // ─────────────────────────────────────
  // SIDEBAR MENU CLICK
  // ─────────────────────────────────────
  void _onMenuSelected(int index) {
    final FeatureModel feature = authService.features[index];
    final String route = _resolveRoute(feature);

    setState(() => selectedMenuIndex = index);

    Get.offNamed(route, id: 1);

    if (isMobile) {
      Navigator.of(context).pop();
    }
  }

  // ─────────────────────────────────────
  // PROFILE MENU HANDLER
  // ─────────────────────────────────────
  void _onProfileSelected(String value) {
    setState(() => selectedProfileOption = value);

    switch (value) {
      case 'Logout':
        authService.logout();
        Get.offAllNamed(AppRoutes.LOGIN);
        break;

      case 'Profile':
        // TODO: Navigate to profile page
        break;

      case 'Settings':
        // TODO: Navigate to settings page
        break;
    }
  }

  // ─────────────────────────────────────
  // FEATURE → ROUTE
  // ─────────────────────────────────────
  String _resolveRoute(FeatureModel feature) {
    switch (feature.name.toUpperCase()) {
      case 'USERS':
        return AppRoutes.USERS;
      case 'ROLES':
        return AppRoutes.ROLES;
      case 'FEATURES':
        return AppRoutes.FEATURES;
      default:
        return AppRoutes.FEATURES;
    }
  }

  // ─────────────────────────────────────
  // SYNC MENU WITH CURRENT URL
  // ─────────────────────────────────────
  void _syncMenuWithRoute() {
    final route = Get.currentRoute;

    final index = authService.features.indexWhere(
      (f) => route.endsWith(_resolveRoute(f)),
    );

    if (index >= 0) {
      selectedMenuIndex = index;
    }
  }
}
