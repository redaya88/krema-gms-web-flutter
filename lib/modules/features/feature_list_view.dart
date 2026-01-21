import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'feature_controller.dart';
import 'widgets/feature_table.dart';
import '../../core/routes/app_routes.dart';

class FeatureListView extends GetView<FeatureController> {
  const FeatureListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Features'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.fetchFeatures,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(AppRoutes.FEATURE_FORM),
        child: const Icon(Icons.add),
      ),
      body: Obx(() {
        if (controller.loading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return FeatureTable(
          features: controller.features,
          onEdit: (feature) =>
              Get.toNamed(AppRoutes.FEATURE_FORM, arguments: feature),
          onDelete: (id) => controller.deleteFeature(id),
        );
      }),
    );
  }
}
