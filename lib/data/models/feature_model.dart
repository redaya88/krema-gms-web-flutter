class FeatureModel {
  final int id;
  final int parent;
  final int featureIndex;
  final String name;
  final String description;
  final bool banned;

  FeatureModel({
    required this.id,
    required this.parent,
    required this.featureIndex,
    required this.name,
    required this.description,
    required this.banned,
  });

  factory FeatureModel.fromJson(Map<String, dynamic> json) {
    return FeatureModel(
      id: json['id'],
      parent: json['parent'],
      featureIndex: json['feature_index'],
      name: json['name'],
      description: json['description'],
      banned: json['banned'],
    );
  }
}
