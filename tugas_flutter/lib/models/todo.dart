import 'package:intl/intl.dart';
import 'todo_category.dart';
import 'label.dart';

enum Priority { rendah, sedang, tinggi }

extension PriorityExtension on Priority {
  String get name {
    switch (this) {
      case Priority.rendah:
        return 'rendah';
      case Priority.sedang:
        return 'sedang';
      case Priority.tinggi:
        return 'tinggi';
    }
  }

  static Priority fromString(String value) {
    switch (value.toLowerCase()) {
      case 'rendah':
        return Priority.rendah;
      case 'sedang':
        return Priority.sedang;
      case 'tinggi':
        return Priority.tinggi;
      default:
        return Priority.rendah;
    }
  }
}

class Todo {
  final int? id;
  final String title;
  final String description;
  final DateTime deadline;
  final Priority status;
  final int categoryId;
  final int labelId;
  TodoCategory? category;
  Label? label;

  Todo({
    this.id,
    required this.title,
    required this.description,
    required this.deadline,
    required this.status,
    required this.categoryId,
    required this.labelId,
    this.category,
    this.label,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      description: json['description'] ?? '',
      deadline: DateTime.parse(json['deadline']),
      status: PriorityExtension.fromString(json['status']),
      categoryId: json['category_id'],
      labelId: json['label_id'],
      category: json['category'] != null
          ? TodoCategory.fromJson(json['category'])
          : null,
      label: json['label'] != null ? Label.fromJson(json['label']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'deadline': DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(deadline),
      'status': status.name,
      'category_id': categoryId,
      'label_id': labelId,
    };
  }

  bool isDeadlineNear() {
    final now = DateTime.now();
    final difference = deadline.difference(now);
    return difference.inHours <= 24 && difference.inHours >= 0;
  }
}
