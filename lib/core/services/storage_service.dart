import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageService extends GetxService {
  final box = GetStorage();

  /// Save access token
  void saveToken(String token) {
    box.write('accessToken', token);
  }

  /// Save refresh token
  void saveRefreshToken(String token) {
    box.write('refreshToken', token);
  }

  /// Clear all stored data
  void clear() {
    box.erase();
  }

  /// Get tokens
  String? get accessToken => box.read('accessToken');
  String? get refreshToken => box.read('refreshToken');

  /// Initialize service (optional, required for async init)
  Future<StorageService> init() async {
    await GetStorage.init();
    return this;
  }
}
