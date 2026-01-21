import 'package:get/get.dart';
import 'package:krema_gms_web/data/models/feature_model.dart';
import 'package:krema_gms_web/data/providers/feature_provider.dart';

class FeatureController extends GetxController {
  final FeatureProvider provider;

  FeatureController(this.provider);

  final features = <FeatureModel>[].obs;
  final loading = false.obs;

  @override
  void onInit() {
    fetchFeatures();
    super.onInit();
  }

  Future<void> fetchFeatures() async {
    try {
      loading.value = true;
      features.value = await provider.getFeatures(); // ✅ FIX
    } finally {
      loading.value = false;
    }
  }

  Future<void> createFeature(FeatureModel feature) async {
    await provider.createFeature(feature);
    fetchFeatures();
  }

  Future<void> updateFeature(int id, FeatureModel feature) async {
    await provider.updateFeature(id, feature);
    fetchFeatures();
  }

  Future<void> deleteFeature(int id) async {
    await provider.deleteFeature(id);
    fetchFeatures();
  }
}
