import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'feature_controller.dart';
import '../../data/models/feature_model.dart';
import 'widgets/feature_form.dart';

class FeatureFormView extends GetView<FeatureController> {
  const FeatureFormView({super.key});

  @override
  Widget build(BuildContext context) {
    final FeatureModel? feature = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(feature == null ? 'Create Feature' : 'Edit Feature'),
      ),
      body: FeatureForm(
        feature: feature,
        onSubmit: (model) async {
          if (feature == null) {
            await controller.createFeature(model);
          } else {
            await controller.updateFeature(feature.id, model);
          }
          Get.back();
        },
      ),
    );
  }
}
