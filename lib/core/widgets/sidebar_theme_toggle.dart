import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/services/theme_service.dart';
import 'package:krema_gms_web/core/widgets/theme_segmented_toggle.dart';

class SidebarThemeToggle extends StatelessWidget {
  final bool expanded;
  final themeService = Get.find<ThemeService>();

  SidebarThemeToggle({super.key, required this.expanded});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Obx(() {
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
                  isDark ? Icons.nightlight_round : Icons.wb_sunny_outlined,
                  size: 24,
                  color: theme.colorScheme.onSurface,
                ),
              ),
      );
    });
  }
}
