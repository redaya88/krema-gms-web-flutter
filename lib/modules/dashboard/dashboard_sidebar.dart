import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/services/auth_service.dart';

class DashboardSidebar extends StatelessWidget {
  final bool expanded;
  final String? selectedFeature;
  final Function(String) onFeatureSelect;

  const DashboardSidebar({
    super.key,
    required this.expanded,
    required this.selectedFeature,
    required this.onFeatureSelect,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authService = Get.find<AuthService>();
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // HEADER
        Container(
          padding: const EdgeInsets.all(16),
          child: expanded
              ? Text(
                  'Logged in as ${authService.currentUser.value?.username ?? ''}',
                  style: theme.textTheme.bodySmall,
                  overflow: TextOverflow.ellipsis,
                )
              : const Icon(Icons.account_circle, size: 28),
        ),

        const SizedBox(height: 8),

        // FEATURE LIST
        Expanded(
          child: Obx(() {
            final features = authService.features;
            if (features.isEmpty) return const SizedBox();

            return ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: features.length,
              itemBuilder: (_, index) {
                final feature = features[index];
                final isActive = selectedFeature == feature.name;

                return _SidebarItem(
                  expanded: expanded,
                  title: feature.name,
                  iconPath:
                      isDark ? feature.darkIconPath : feature.lightIconPath,
                  active: isActive,
                  onTap: () => onFeatureSelect(feature.name),
                );
              },
            );
          }),
        ),
      ],
    );
  }
}

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
