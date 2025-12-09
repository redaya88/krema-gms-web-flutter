import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/services/theme_service.dart';

class DashboardTopBar extends StatelessWidget {
  final bool isMobile;
  final bool isSidebarExpanded;
  final String selectedProfileOption;
  final Function() onToggleSidebar;
  final Function(String) onSelectProfileOption;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const DashboardTopBar({
    super.key,
    required this.isMobile,
    required this.isSidebarExpanded,
    required this.selectedProfileOption,
    required this.onToggleSidebar,
    required this.onSelectProfileOption,
    required this.scaffoldKey,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: theme.colorScheme.surface,
      child: Row(
        children: [
          if (isMobile)
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => scaffoldKey.currentState?.openDrawer(),
            ),

          if (!isMobile)
            IconButton(
              icon: Icon(
                isSidebarExpanded
                    ? Icons.arrow_back_ios
                    : Icons.arrow_forward_ios,
              ),
              onPressed: onToggleSidebar,
            ),

          const Spacer(),

          IconButton(
            icon: Icon(
              theme.brightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () => Get.find<ThemeService>().toggleTheme(),
          ),

          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedProfileOption,
              items: ['Profile', 'Settings', 'Logout']
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null) onSelectProfileOption(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}
