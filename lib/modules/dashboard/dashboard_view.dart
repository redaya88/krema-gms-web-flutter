import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/services/auth_service.dart';
import 'dashboard_sidebar.dart';
import 'dashboard_topbar.dart';
import 'dashboard_content.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isSidebarExpanded = true;
  String selectedProfileOption = 'Profile';
  String? selectedFeature;

  final authService = Get.find<AuthService>();

  bool get isMobile => MediaQuery.of(context).size.width < 800;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,

      // ---------- MOBILE SIDEBAR ----------
      drawer: isMobile
          ? Drawer(
              child: DashboardSidebar(
                expanded: true,
                selectedFeature: selectedFeature,
                onFeatureSelect: (f) => setState(() => selectedFeature = f),
                onToggleExpand: () {},
              ),
            )
          : null,

      body: Row(
        children: [
          // ---------- DESKTOP SIDEBAR ----------
          if (!isMobile)
            DashboardSidebar(
              expanded: isSidebarExpanded,
              selectedFeature: selectedFeature,
              onFeatureSelect: (f) => setState(() => selectedFeature = f),
              onToggleExpand: () =>
                  setState(() => isSidebarExpanded = !isSidebarExpanded),
            ),

          // ---------- MAIN CONTENT ----------
          Expanded(
            child: Column(
              children: [
                DashboardTopBar(
                  isMobile: isMobile,
                  isSidebarExpanded: isSidebarExpanded,
                  selectedProfileOption: selectedProfileOption,
                  scaffoldKey: _scaffoldKey,
                  onToggleSidebar: () =>
                      setState(() => isSidebarExpanded = !isSidebarExpanded),
                  onSelectProfileOption: _onSelectProfileOption,
                ),
                Expanded(
                  child: DashboardContent(
                    selectedFeature: selectedFeature,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onSelectProfileOption(String value) {
    setState(() => selectedProfileOption = value);
    if (value == 'Logout') authService.logout();
  }
}
