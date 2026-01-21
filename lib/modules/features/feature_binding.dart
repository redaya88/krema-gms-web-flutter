import 'package:get/get.dart';
import 'package:krema_gms_web/data/providers/feature_provider.dart';
import 'feature_controller.dart';

class FeatureBinding extends Bindings {
  @override
  void dependencies() {
    /// Provider (HTTP / API)
    Get.lazyPut<FeatureProvider>(() => FeatureProvider());

    /// Controller (Business Logic)
    Get.lazyPut<FeatureController>(
      () => FeatureController(Get.find<FeatureProvider>()),
    );
  }
}
