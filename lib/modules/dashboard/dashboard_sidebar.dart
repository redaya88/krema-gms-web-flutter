import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/services/auth_service.dart';
import '../../core/widgets/sidebar_icon.dart';
import '../../core/widgets/sidebar_item.dart';
import '../../core/widgets/sidebar_theme_toggle.dart';
import '../../core/widgets/menu_icon_helper.dart';
import '../../core/widgets/sidebar_constants.dart';

class DashboardSidebar extends StatelessWidget {
  final bool expanded;
  final String? selectedFeature;
  final ValueChanged<String> onFeatureSelect;
  final VoidCallback onToggleExpand;

  const DashboardSidebar({
    super.key,
    required this.expanded,
    required this.selectedFeature,
    required this.onFeatureSelect,
    required this.onToggleExpand,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final auth = Get.find<AuthService>();
    final isDark = theme.brightness == Brightness.dark;

    return AnimatedContainer(
      duration: SidebarConstants.animationDuration,
      width: expanded
          ? SidebarConstants.expandedWidth
          : SidebarConstants.collapsedWidth,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          right: BorderSide(
            color: theme.dividerColor.withOpacity(0.4),
          ),
        ),
      ),
      child: Column(
        children: [
          // HEADER
          Padding(
            padding: SidebarConstants.headerPadding,
            child: Row(
              children: [
                SidebarIcon(
                  iconPath:
                      MenuIconHelper.iconPath(expanded, isDark),
                  onTap: onToggleExpand,
                ),
                if (expanded) ...[
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('OMS',
                            style:
                                TextStyle(fontWeight: FontWeight.bold)),
                        Text(
                          'Optical Management System',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),

          const SizedBox(height: 8),

          // FEATURES
          Expanded(
            child: Obx(() {
              return ListView.builder(
                padding: EdgeInsets.fromLTRB(
                  expanded ? 10 : 0,
                  16,
                  16,
                  16,
                ),
                itemCount: auth.features.length,
                itemBuilder: (_, i) {
                  final f = auth.features[i];
                  return SidebarItem(
                    expanded: expanded,
                    active: selectedFeature == f.name,
                    title: f.name,
                    iconPath:
                        isDark ? f.darkIconPath : f.lightIconPath,
                    onTap: () => onFeatureSelect(f.name),
                  );
                },
              );
            }),
          ),

          // FOOTER
          Padding(
            padding: const EdgeInsets.all(8),
            child: SidebarThemeToggle(expanded: expanded),
          ),
        ],
      ),
    );
  }
}
