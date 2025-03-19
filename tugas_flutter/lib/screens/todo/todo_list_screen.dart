import 'package:flutter/material.dart';
import 'package:flutter_todo_app/screens/todo/todo_form_screen.dart';
import 'package:provider/provider.dart';
import '../../providers/todo_provider.dart';
import '../../widgets/todo_card.dart';
import '../../widgets/custom_app_bar.dart';

class TodoListScreen extends StatelessWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Todo List',
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: null, // Implement search functionality
          ),
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: null, // Implement sort functionality
          ),
        ],
      ),
      body: Consumer<TodoProvider>(
        builder: (context, todoProvider, _) {
          if (todoProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (todoProvider.error != null) {
            return Center(child: Text('Error: ${todoProvider.error}'));
          }
          return ListView.builder(
            itemCount: todoProvider.filteredTodos.length,
            itemBuilder: (context, index) {
              final todo = todoProvider.filteredTodos[index];
              return TodoCard(todo: todo);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to Todo Form Screen
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const TodoFormScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
