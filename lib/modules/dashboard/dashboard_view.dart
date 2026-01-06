import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krema_gms_web/core/widgets/sidebar/app_sidebar.dart';

import '../../core/services/auth_service.dart';
// import 'app_sidebar.dart';
// import 'dashboard_topbar.dart';
// import 'dashboard_content.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final authService = Get.find<AuthService>();

  bool isSidebarExpanded = true;
  int selectedMenuIndex = 0;

  bool get isMobile => MediaQuery.of(context).size.width < 800;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,

      // ───────── MOBILE DRAWER ─────────
      drawer: isMobile
          ? Drawer(
              child: AppSidebar(
                expanded: true, // 👈 always expanded on mobile
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

          // // ───────── MAIN CONTENT ─────────
          // Expanded(
          //   child: Column(
          //     children: [
          //       DashboardTopBar(
          //         isMobile: isMobile,
          //         isSidebarExpanded: isSidebarExpanded,
          //         onToggleSidebar: () =>
          //             setState(() => isSidebarExpanded = !isSidebarExpanded),
          //         onOpenDrawer: () =>
          //             _scaffoldKey.currentState?.openDrawer(),
          //       ),
          //       Expanded(
          //         child: DashboardContent(
          //           selectedIndex: selectedMenuIndex,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  void _onMenuSelected(int index) {
    setState(() => selectedMenuIndex = index);
  }
}
