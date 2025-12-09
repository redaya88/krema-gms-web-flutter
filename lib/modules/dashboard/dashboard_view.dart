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
  bool isSidebarExpanded = true;
  String selectedProfileOption = 'Profile';
  String? selectedFeature;

  final authService = Get.find<AuthService>();
  final List<String> profileOptions = ['Profile', 'Settings', 'Logout'];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool get isMobile => MediaQuery.of(context).size.width < 800;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      key: _scaffoldKey,
      drawer: isMobile ? Drawer(child: DashboardSidebar(expanded: true, selectedFeature: selectedFeature, onFeatureSelect: _onSelectFeature)) : null,
      body: Row(
        children: [
          // Desktop Sidebar
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

          // Main Area
          Expanded(
            child: Column(
              children: [
                DashboardTopBar(
                  isMobile: isMobile,
                  isSidebarExpanded: isSidebarExpanded,
                  selectedProfileOption: selectedProfileOption,
                  onToggleSidebar: () {
                    setState(() => isSidebarExpanded = !isSidebarExpanded);
                  },
                  onSelectProfileOption: _onSelectProfileOption,
                  scaffoldKey: _scaffoldKey,
                ),

                Expanded(
                  child: DashboardContent(selectedFeature: selectedFeature),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onSelectFeature(String featureName) {
    setState(() => selectedFeature = featureName);
    if (isMobile) Navigator.of(context).pop();
  }

  void _onSelectProfileOption(String value) {
    setState(() => selectedProfileOption = value);
    if (value == 'Logout') {
      authService.logout();
    }
  }
}
