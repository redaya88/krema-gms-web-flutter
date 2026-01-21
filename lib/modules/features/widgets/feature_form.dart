import 'package:flutter/material.dart';
import '../../../data/models/feature_model.dart';

class FeatureForm extends StatefulWidget {
  final FeatureModel? feature;
  final void Function(FeatureModel model) onSubmit;

  const FeatureForm({
    super.key,
    this.feature,
    required this.onSubmit,
  });

  @override
  State<FeatureForm> createState() => _FeatureFormState();
}

class _FeatureFormState extends State<FeatureForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameCtrl;
  late final TextEditingController _descCtrl;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.feature?.name ?? '');
    _descCtrl = TextEditingController(text: widget.feature?.description ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nameCtrl,
              decoration: const InputDecoration(labelText: 'Feature Name'),
              validator: (v) =>
                  v == null || v.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descCtrl,
              decoration: const InputDecoration(labelText: 'Description'),
              validator: (v) =>
                  v == null || v.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (!_formKey.currentState!.validate()) return;

                final model = FeatureModel(
                  id: widget.feature?.id ?? 0,
                  parent: widget.feature?.parent ?? 0,
                  featureIndex: widget.feature?.featureIndex ?? 0,
                  name: _nameCtrl.text,
                  description: _descCtrl.text,
                  banned: widget.feature?.banned ?? false,
                  lightIconPath: widget.feature?.lightIconPath ?? '',
                  darkIconPath: widget.feature?.darkIconPath ?? '',
                );

                widget.onSubmit(model);
              },
              child: const Text('Save'),
            )
          ],
        ),
      ),
    );
  }
}
