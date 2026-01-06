import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/services/theme_service.dart';
import 'theme_segmented_toggle.dart';

class SidebarThemeToggle extends StatelessWidget {
  final bool expanded;
  final themeService = Get.find<ThemeService>();

  SidebarThemeToggle({
    super.key,
    required this.expanded,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Obx(() {
      final isDark = themeService.isDarkMode.value;

      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        child: expanded
            // ───────────── EXPANDED ─────────────
            ? ThemeSegmentedToggle(
                key: const ValueKey('expanded'),
                isDark: isDark,
                onChanged: (value) {
                  if (value != isDark) {
                    themeService.toggleTheme();
                  }
                },
                expanded: expanded,
              )

            // ───────────── COLLAPSED ─────────────
            : Tooltip(
                key: const ValueKey('collapsed'),
                message: isDark ? 'Dark mode' : 'Light mode',
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () => themeService.toggleTheme(),
                      child: Center(
                        child: Icon(
                          isDark
                              ? Icons.nightlight_round
                              : Icons.wb_sunny_outlined,
                          size: 22,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      );
    });
  }
}
