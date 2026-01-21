import 'package:krema_gms_web/core/network/api_response.dart';

import '../models/feature_model.dart';
import 'auth_provider.dart';

class FeatureProvider {
  final AuthProvider _auth = AuthProvider.instance;

  /// READ
  Future<List<FeatureModel>> getFeatures() async {
    final response = await _auth.get('/features');

    if (!response.isOk || response.body == null) {
      return [];
    }

    final apiResponse = ApiResponse.fromJson(
      response.body,
      (json) => (json as List).map((e) => FeatureModel.fromJson(e)).toList(),
    );

    return apiResponse.data;
  }

  /// CREATE
  Future<void> createFeature(FeatureModel feature) async {
    final res = await _auth.post('/features', feature.toJson());
    if (!res.isOk) {
      throw Exception(res.statusText);
    }
  }

  /// UPDATE
  Future<void> updateFeature(int id, FeatureModel feature) async {
    final res = await _auth.put('/features/$id', feature.toJson());
    if (!res.isOk) {
      throw Exception(res.statusText);
    }
  }

  /// DELETE (soft delete using banned flag)
  Future<void> deleteFeature(int id) async {
    final res = await _auth.delete('/features/$id');
    if (!res.isOk) {
      throw Exception(res.statusText);
    }
  }
}
