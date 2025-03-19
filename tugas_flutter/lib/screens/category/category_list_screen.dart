import 'package:flutter/material.dart';
import 'package:flutter_todo_app/screens/category/category_form_screen.dart';
import 'package:provider/provider.dart';
import '../../providers/category_provider.dart';
import '../../widgets/category_card.dart';
import '../../widgets/custom_app_bar.dart';

class CategoryListScreen extends StatelessWidget {
  const CategoryListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Categories'),
      body: Consumer<CategoryProvider>(
        builder: (context, categoryProvider, _) {
          if (categoryProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (categoryProvider.error != null) {
            return Center(child: Text('Error: ${categoryProvider.error}'));
          }
          return ListView.builder(
            itemCount: categoryProvider.categories.length,
            itemBuilder: (context, index) {
              final category = categoryProvider.categories[index];
              return CategoryCard(category: category);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to Category Form Screen
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const CategoryFormScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
