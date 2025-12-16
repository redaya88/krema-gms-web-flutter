import 'package:flutter/material.dart';

import '../../core/widgets/web_profile_menu.dart';

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
          // if (isMobile)
          //   IconButton(
          //     icon: const Icon(Icons.menu),
          //     onPressed: () => scaffoldKey.currentState?.openDrawer(),
          //   ),
          // if (!isMobile)
          //   IconButton(
          //     icon: Icon(
          //       isSidebarExpanded
          //           ? Icons.arrow_back_ios
          //           : Icons.arrow_forward_ios,
          //     ),
          //     onPressed: onToggleSidebar,
          //   ),
          const Spacer(),
          WebProfileMenu(
            username: "Cahya Nugraha",
            role: "Administrator",
            onSelect: (value) => onSelectProfileOption(value),
          ),
          // DropdownButtonHideUnderline(
          //   child: DropdownButton<String>(
          //     value: selectedProfileOption,
          //     items: ['Profile', 'Settings', 'Logout']
          //         .map((e) => DropdownMenuItem(
          //               value: e,
          //               child: Text(e),
          //             ))
          //         .toList(),
          //     onChanged: (value) {
          //       if (value != null) onSelectProfileOption(value);
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
