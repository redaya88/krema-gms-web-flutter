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

    return Column(
      children: [
        const SizedBox(height: 20),
        Expanded(
          child: Obx(() {
            final features = authService.features;
            if (features.isEmpty) return const SizedBox();

            return ListView.builder(
              itemCount: features.length,
              itemBuilder: (_, index) {
                final feature = features[index];
                final isActive = selectedFeature == feature.name;
                final isDark = theme.brightness == Brightness.dark;

                return ListTile(
                  leading: Image.asset(
                    isDark ? feature.darkIconPath : feature.lightIconPath,
                    width: 22,
                    height: 22,
                  ),
                  title: expanded
                      ? Text(
                          feature.name,
                          style: TextStyle(color: theme.colorScheme.onSurface),
                          overflow: TextOverflow.ellipsis,
                        )
                      : null,
                  selected: isActive,
                  onTap: () => onFeatureSelect(feature.name),
                  horizontalTitleGap: 10,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: expanded ? 16 : 8,
                  ),
                );
              },
            );
          }),
        ),
      ],
    );
  }
}
