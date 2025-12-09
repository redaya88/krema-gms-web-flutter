import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/services/auth_service.dart';

class DashboardContent extends StatelessWidget {
  final String? selectedFeature;

  const DashboardContent({super.key, required this.selectedFeature});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authService = Get.find<AuthService>();

    return Container(
      color: theme.colorScheme.surface,
      child: Center(
        child: Text(
          'Welcome, ${authService.currentUser.value?.username ?? ''}',
          style: theme.textTheme.headlineSmall,
        ),
      ),
    );
  }
}
