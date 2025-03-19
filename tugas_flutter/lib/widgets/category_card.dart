import 'package:flutter/material.dart';
import 'package:flutter_todo_app/screens/category/category_form_screen.dart';
import '../models/todo_category.dart';

class CategoryCard extends StatelessWidget {
  final TodoCategory category;

  const CategoryCard({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(category.title),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            // Implement delete functionality
          },
        ),
        onTap: () {
          // Navigate to Category Form Screen for editing
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => CategoryFormScreen(category: category),
            ),
          );
        },
      ),
    );
  }
}
