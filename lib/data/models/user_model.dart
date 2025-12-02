import 'role_model.dart';
import 'shop_model.dart';

class UserModel {
  final int id;
  final String username;
  final String email;
  final List<RoleModel> roles;
  final ShopModel? shop;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.roles,
    required this.shop,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      roles: (json['roles'] as List)
          .map((e) => RoleModel.fromJson(e))
          .toList(),
      shop: json['shop'] != null ? ShopModel.fromJson(json['shop']) : null,
    );
  }
}
