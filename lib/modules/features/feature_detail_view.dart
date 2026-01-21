import 'package:flutter/material.dart';
import '../../data/models/feature_model.dart';

class FeatureDetailView extends StatelessWidget {
  final FeatureModel feature;

  const FeatureDetailView({super.key, required this.feature});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(feature.name)),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Description: ${feature.description}'),
            Text('Status: ${feature.banned ? "Banned" : "Active"}'),
          ],
        ),
      ),
    );
  }
}
