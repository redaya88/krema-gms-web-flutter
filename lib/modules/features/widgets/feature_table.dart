import 'package:flutter/material.dart';
import '../../../data/models/feature_model.dart';

class FeatureTable extends StatelessWidget {
  final List<FeatureModel> features;
  final void Function(FeatureModel feature) onEdit;
  final void Function(int id) onDelete;

  const FeatureTable({
    super.key,
    required this.features,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: DataTable(
        columns: const [
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('Name')),
          DataColumn(label: Text('Description')),
          DataColumn(label: Text('Status')),
          DataColumn(label: Text('Actions')),
        ],
        rows: features.map((f) {
          return DataRow(cells: [
            DataCell(Text(f.id.toString())),
            DataCell(Text(f.name)),
            DataCell(Text(f.description)),
            DataCell(Text(f.banned ? 'Banned' : 'Active')),
            DataCell(Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => onEdit(f),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => onDelete(f.id),
                ),
              ],
            )),
          ]);
        }).toList(),
      ),
    );
  }
}
