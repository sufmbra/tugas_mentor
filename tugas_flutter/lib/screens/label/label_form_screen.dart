import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/label.dart';
import '../../providers/label_provider.dart';

class LabelFormScreen extends StatefulWidget {
  final Label? label;

  const LabelFormScreen({Key? key, this.label}) : super(key: key);

  @override
  _LabelFormScreenState createState() => _LabelFormScreenState();
}

class _LabelFormScreenState extends State<LabelFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.label != null) {
      _titleController.text = widget.label!.title;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.label == null ? 'Add Label' : 'Edit Label'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final labelProvider = Provider.of<LabelProvider>(
                      context,
                      listen: false,
                    );
                    final label = Label(
                      id: widget.label?.id,
                      title: _titleController.text,
                    );
                    if (widget.label == null) {
                      await labelProvider.createLabel(label);
                    } else {
                      await labelProvider.updateLabel(widget.label!.id!, label);
                    }
                    Navigator.of(context).pop();
                  }
                },
                child: Text(
                  widget.label == null ? 'Add Label' : 'Update Label',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
