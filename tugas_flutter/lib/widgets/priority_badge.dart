import 'package:flutter/material.dart';
import '../../models/todo.dart';

class PriorityBadge extends StatelessWidget {
  final Priority priority;

  const PriorityBadge({Key? key, required this.priority}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (priority) {
      case Priority.rendah:
        color = Colors.green;
        break;
      case Priority.sedang:
        color = Colors.orange;
        break;
      case Priority.tinggi:
        color = Colors.red;
        break;
    }
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        priority.name.toUpperCase(),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
