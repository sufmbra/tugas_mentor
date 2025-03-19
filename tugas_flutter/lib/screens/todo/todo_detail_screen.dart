import 'package:flutter/material.dart';
import 'package:flutter_todo_app/screens/todo/todo_form_screen.dart';
import 'package:provider/provider.dart';
import '../../models/todo.dart';
import '../../providers/todo_provider.dart';
import '../../widgets/todo_card.dart';

class TodoDetailScreen extends StatelessWidget {
  final Todo todo;

  const TodoDetailScreen({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(todo.title)),
      body: Consumer<TodoProvider>(
        builder: (context, todoProvider, _) {
          return TodoCard(todo: todo);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to Todo Form Screen for editing
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => TodoFormScreen(todo: todo)));
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}
