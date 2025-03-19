import 'package:flutter/material.dart';
import '../../models/label.dart';

class LabelChip extends StatelessWidget {
  final Label label;

  const LabelChip({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label.title),
      deleteIcon: const Icon(Icons.delete),
      onDeleted: () {
        // Implement delete functionality
      },
      avatar: const CircleAvatar(child: Icon(Icons.label)),
    );
  }
}
