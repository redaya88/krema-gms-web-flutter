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
  final VoidCallback onToggleExpand;

  DashboardSidebar({
    super.key,
    required this.expanded,
    required this.selectedFeature,
    required this.onFeatureSelect,
    required this.onToggleExpand,
  });

  final themeService = Get.find<ThemeService>();

  static const double _buttonSize = 36;
  static const double _buttonRadius = _buttonSize / 2;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double panelWidth = expanded ? 260 : 78;

    return SizedBox(
      width: panelWidth + _buttonRadius, // ⭐ KEY FIX
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // ---------- SIDEBAR PANEL ----------
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: panelWidth,
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              border: Border(
                right: BorderSide(
                  color: theme.dividerColor.withOpacity(0.4),
                  width: 1,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 12,
                  offset: const Offset(2, 0),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ---------- HEADER ----------
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: expanded
                      ? Row(
                          children: [
                            Image.asset(
                              'assets/icons/logo-small-light.png',
                              width: 34,
                              height: 34,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'OMS',
                                    style: theme.textTheme.labelLarge
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Optical Management System',
                                    style: theme.textTheme.bodySmall
                                        ?.copyWith(color: Colors.grey),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : Image.asset('assets/icons/logo-small-light.png'),
                ),

                const SizedBox(height: 12),

                // ---------- FEATURES ----------
                Expanded(
                  child: Obx(() {
                    final features = Get.find<AuthService>().features;
                    final isDark =
                        theme.brightness == Brightness.dark;

                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: features.length,
                      itemBuilder: (_, i) {
                        final feature = features[i];
                        return SidebarItem(
                          expanded: expanded,
                          title: feature.name,
                          iconPath: isDark
                              ? feature.darkIconPath
                              : feature.lightIconPath,
                          active: selectedFeature == feature.name,
                          onTap: () => onFeatureSelect(feature.name),
                        );
                      },
                    );
                  }),
                ),

                // ---------- THEME TOGGLE ----------
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SidebarThemeToggle(expanded: expanded),
                ),
              ],
            ),
          ),

          // ---------- FLOATING TOGGLE BUTTON ----------
          Positioned(
            top: 40,
            right: 0, // 👈 no negative offset
            child: _ExpandButton(
              expanded: expanded,
              onTap: onToggleExpand,
            ),
          ),
        ],
      ),
    );
  }
}

/// ============================================================
/// FLOATING BUTTON
/// ============================================================
class _ExpandButton extends StatefulWidget {
  final bool expanded;
  final VoidCallback onTap;

  const _ExpandButton({
    required this.expanded,
    required this.onTap,
  });

  @override
  State<_ExpandButton> createState() => _ExpandButtonState();
}

class _ExpandButtonState extends State<_ExpandButton> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MouseRegion(
      onEnter: (_) => setState(() => hovering = true),
      onExit: (_) => setState(() => hovering = false),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 150),
        scale: hovering ? 1.12 : 1.0,
        child: GestureDetector(
          onTap: widget.onTap,
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Icon(
              widget.expanded
                  ? Icons.chevron_left
                  : Icons.chevron_right,
              color: Colors.black,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
