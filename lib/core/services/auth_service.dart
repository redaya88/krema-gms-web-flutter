import 'package:get/get.dart';
import '../../data/models/user_model.dart';
import '../../data/models/feature_model.dart';
import 'storage_service.dart';
import '../../data/providers/auth_provider.dart';

class AuthService extends GetxService {
  final isLoggedIn = false.obs;
  final currentUser = Rxn<UserModel>();
  final features = <FeatureModel>[].obs;

  final _provider = AuthProvider.instance; // use singleton

  /// Login method
  Future<bool> login(String username, String password) async {
    final response = await _provider.login(username, password);

    if (!response.isOk || response.body == null) return false;

    final data = response.body['data'];
    if (data == null) return false;

    final userJson = data['user'];
    final featuresJson = data['features'] ?? [];
    final accessToken = data['accessToken'];
    final refreshToken = data['refreshToken'];

    if (userJson == null || accessToken == null || refreshToken == null) return false;

    // Save current user
    currentUser.value = UserModel.fromJson(userJson);

    // Save features
    features.value = List<FeatureModel>.from(
      featuresJson.map((x) => FeatureModel.fromJson(x)),
    );

    // Save tokens
    final storage = Get.find<StorageService>();
    storage.saveToken(accessToken);
    storage.saveRefreshToken(refreshToken);

    isLoggedIn.value = true;
    return true;
  }

  /// Logout
  void logout() {
    currentUser.value = null;
    features.clear();
    isLoggedIn.value = false;
    Get.find<StorageService>().clear();
  }
}
