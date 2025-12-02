class ShopModel {
  final int id;
  final String name;
  final String address;

  ShopModel({
    required this.id,
    required this.name,
    required this.address,
  });

  factory ShopModel.fromJson(Map<String, dynamic> json) {
    return ShopModel(
      id: json['id'],
      name: json['name'],
      address: json['address'],
    );
  }
}