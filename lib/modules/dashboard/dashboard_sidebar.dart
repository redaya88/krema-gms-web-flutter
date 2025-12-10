import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/services/auth_service.dart';
import '../../core/services/theme_service.dart';
import 'package:krema_gms_web/core/widgets/theme_segmented_toggle.dart';

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

              return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: features.length,
                itemBuilder: (_, index) {
                  final feature = features[index];
                  final isDark = theme.brightness == Brightness.dark;

                  return _SidebarItem(
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

          // ---------------- THEME TOGGLE ----------------
          Padding(
            padding: const EdgeInsets.all(16),
            child: Obx(() {
              final isDark = themeService.isDarkMode.value;

              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: SizeTransition(
                      sizeFactor: animation,
                      axis: Axis.horizontal,
                      child: child,
                    ),
                  );
                },
                child: expanded
                    ? ThemeSegmentedToggle(
                        key: const ValueKey('full_toggle'),
                        isDark: isDark,
                        onChanged: (value) {
                          if (value != isDark) themeService.toggleTheme();
                        },
                      )
                    : GestureDetector(
                        key: const ValueKey('icon_only'),
                        onTap: () => themeService.toggleTheme(),
                        child: Icon(
                          isDark
                              ? Icons.nightlight_round
                              : Icons.wb_sunny_outlined,
                          size: 24,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

/// ------------------- SIDEBAR ITEM -------------------
class _SidebarItem extends StatelessWidget {
  final bool expanded;
  final bool active;
  final String title;
  final String iconPath;
  final VoidCallback onTap;

  const _SidebarItem({
    required this.expanded,
    required this.active,
    required this.title,
    required this.iconPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Material(
        color: active
            ? theme.colorScheme.primary.withOpacity(0.12)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            padding: EdgeInsets.symmetric(
              horizontal: expanded ? 12 : 0,
              vertical: 10,
            ),
            child: expanded
                ? Row(
                    children: [
                      _buildIcon(),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          title,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight:
                                active ? FontWeight.w600 : FontWeight.w400,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ],
                  )
                : Center(child: _buildIcon()),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return SizedBox(
      width: 24,
      height: 24,
      child: Image.asset(
        iconPath,
        fit: BoxFit.contain,
      ),
    );
  }
}
