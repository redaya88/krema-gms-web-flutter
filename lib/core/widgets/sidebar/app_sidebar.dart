import 'package:flutter/material.dart';
import 'package:krema_gms_web/core/widgets/sidebar/sidebar_header.dart';
import 'package:krema_gms_web/core/widgets/sidebar/sidebar_item.dart';
import 'package:krema_gms_web/core/widgets/sidebar_theme_toggle.dart';

class SidebarMenu {
  final IconData icon;
  final String title;

  const SidebarMenu({
    required this.icon,
    required this.title,
  });
}

class AppSidebar extends StatelessWidget {
  final bool expanded;
  final VoidCallback onToggle;
  final int selectedIndex;
  final ValueChanged<int> onMenuSelected;

  const AppSidebar({
    super.key,
    required this.expanded,
    required this.onToggle,
    required this.selectedIndex,
    required this.onMenuSelected,
  });

  // ✅ DEFINE MENUS HERE
  static const List<SidebarMenu> menus = [
    SidebarMenu(icon: Icons.dashboard, title: 'Dashboard'),
    SidebarMenu(icon: Icons.people, title: 'Users'),
    SidebarMenu(icon: Icons.settings, title: 'Settings'),
    SidebarMenu(icon: Icons.logout, title: 'Logout'),
  ];

  static const double expandedWidth = 260;
  static const double collapsedWidth = 72;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: expanded ? expandedWidth : collapsedWidth,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 12,
            offset: Offset(2, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          SidebarHeader(
            expanded: expanded,
            onToggle: onToggle,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Divider(
              height: 16,
              thickness: 1,
              color: Theme.of(context).dividerColor.withOpacity(0.6),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: menus.length,
              itemBuilder: (context, index) {
                final menu = menus[index];
                return SidebarItem(
                  expanded: expanded,
                  icon: menu.icon,
                  title: menu.title,
                  active: index == selectedIndex,
                  onTap: () => onMenuSelected(index),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: SidebarThemeToggle(expanded: expanded),
          )
        ],
      ),
    );
  }
}
