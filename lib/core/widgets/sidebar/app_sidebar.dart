import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krema_gms_web/core/services/auth_service.dart';
import 'package:krema_gms_web/core/widgets/sidebar/sidebar_header.dart';
import 'package:krema_gms_web/core/widgets/sidebar/sidebar_item.dart';
import 'package:krema_gms_web/core/widgets/sidebar_theme_toggle.dart';

class SidebarMenu {
  final String icon;
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


  static const double expandedWidth = 260;
  static const double collapsedWidth = 72;

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthService>();
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

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
              itemCount: auth.features.length,
              itemBuilder: (context, index) {
                final f = auth.features[index];
                return SidebarItem(
                  expanded: expanded,
                  icon: isDark ? f.darkIconPath : f.lightIconPath,
                  title: f.name,
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
