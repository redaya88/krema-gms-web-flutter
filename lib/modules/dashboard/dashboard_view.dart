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
  final List<String> profileOptions = ['Profile', 'Settings', 'Logout'];

  bool get isMobile => MediaQuery.of(context).size.width < 800;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      key: _scaffoldKey,

      // ---------- MOBILE SIDEBAR (DRAWER) ----------
      drawer: isMobile
          ? Drawer(
              child: SizedBox(
                width: 260, // IMPORTANT – prevents ListTile crash
                child: DashboardSidebar(
                  expanded: true,
                  selectedFeature: selectedFeature,
                  onFeatureSelect: _onSelectFeature,
                ),
              ),
            )
          : null,

      body: Row(
        children: [
          // ---------- DESKTOP SIDEBAR ----------
          if (!isMobile)
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: isSidebarExpanded ? 220 : 60,
              color: theme.colorScheme.surface,
              child: DashboardSidebar(
                expanded: isSidebarExpanded,
                selectedFeature: selectedFeature,
                onFeatureSelect: _onSelectFeature,
              ),
            ),

          // ---------- MAIN PAGE ----------
          Expanded(
            child: Column(
              children: [
                DashboardTopBar(
                  isMobile: isMobile,
                  isSidebarExpanded: isSidebarExpanded,
                  selectedProfileOption: selectedProfileOption,
                  scaffoldKey: _scaffoldKey,
                  onToggleSidebar: () {
                    setState(() => isSidebarExpanded = !isSidebarExpanded);
                  },
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

  // ---------- FEATURE SELECTION ----------
  void _onSelectFeature(String featureName) {
    setState(() => selectedFeature = featureName);
    if (isMobile) Navigator.pop(context); // close mobile drawer
  }

  // ---------- PROFILE MENU ----------
  void _onSelectProfileOption(String value) {
    setState(() => selectedProfileOption = value);

    if (value == 'Logout') {
      authService.logout();
    }
  }
}
