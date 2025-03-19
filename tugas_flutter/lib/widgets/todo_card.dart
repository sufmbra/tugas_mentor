import 'package:flutter/material.dart';
import 'package:flutter_todo_app/screens/todo/todo_detail_screen.dart';
import 'package:provider/provider.dart';
import '../../models/todo.dart';
import '../../providers/todo_provider.dart';
import '../../widgets/priority_badge.dart';

class TodoCard extends StatelessWidget {
  final Todo todo;

  const TodoCard({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(todo.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(todo.description),
            Row(
              children: [
                Text('Deadline: ${todo.deadline.toLocal()}'.split(' ')[0]),
                const SizedBox(width: 16),
                PriorityBadge(priority: todo.status),
              ],
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () async {
            final todoProvider =
                Provider.of<TodoProvider>(context, listen: false);
            await todoProvider.deleteTodo(todo.id!);
          },
        ),
        onTap: () {
          // Navigate to Todo Detail Screen
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => TodoDetailScreen(todo: todo)),
          );
        },
      ),
    );
  }
}
