import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/todo_category.dart';
import '../../providers/category_provider.dart';

class CategoryFormScreen extends StatefulWidget {
  final TodoCategory? category;

  const CategoryFormScreen({Key? key, this.category}) : super(key: key);

  @override
  _CategoryFormScreenState createState() => _CategoryFormScreenState();
}

class _CategoryFormScreenState extends State<CategoryFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.category != null) {
      _titleController.text = widget.category!.title;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final categoryProvider =
          Provider.of<CategoryProvider>(context, listen: false);
      final category = TodoCategory(
        id: widget.category?.id,
        title: _titleController.text,
      );
      try {
        if (widget.category == null) {
          await categoryProvider.createCategory(category);
        } else {
          await categoryProvider.updateCategory(widget.category!.id!, category);
        }
        if (mounted) {
          Navigator.of(context).pop();
        }
      } catch (e) {
        // Handle exception if needed
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category == null ? 'Add Category' : 'Edit Category'),
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
                onPressed: _submitForm,
                child: Text(
                  widget.category == null ? 'Add Category' : 'Update Category',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
