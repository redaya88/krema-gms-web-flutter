import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/services/auth_service.dart';
import '../../core/services/theme_service.dart';
import '../../core/widgets/sidebar_item.dart';
import '../../core/widgets/sidebar_theme_toggle.dart';

class DashboardSidebar extends StatelessWidget {
  final bool expanded;
  final String? selectedFeature;
  final Function(String) onFeatureSelect;

  DashboardSidebar({
    super.key,
    required this.expanded,
    required this.selectedFeature,
    required this.onFeatureSelect,
  });

  final themeService = Get.find<ThemeService>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: theme.colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADER
          Container(
            padding: const EdgeInsets.all(16),
            child: expanded
                ? Text(
                    'Logged in as ${Get.find<AuthService>().currentUser.value?.username ?? ''}',
                    style: theme.textTheme.bodySmall,
                    overflow: TextOverflow.ellipsis,
                  )
                : const Icon(Icons.account_circle, size: 28),
          ),

          const SizedBox(height: 12),

          // FEATURE LIST
          Expanded(
            child: Obx(() {
              final features = Get.find<AuthService>().features;
              final isDark = theme.brightness == Brightness.dark;

              return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: features.length,
                itemBuilder: (_, index) {
                  final feature = features[index];
                  return SidebarItem(
                    expanded: expanded,
                    title: feature.name,
                    iconPath:
                        isDark ? feature.darkIconPath : feature.lightIconPath,
                    active: selectedFeature == feature.name,
                    onTap: () => onFeatureSelect(feature.name),
                  );
                },
              );
            }),
          ),

          // THEME TOGGLE
          Padding(
            padding: const EdgeInsets.all(16),
            child: SidebarThemeToggle(
              expanded: expanded,
            ),
          ),
        ],
      ),
    );
  }
}
