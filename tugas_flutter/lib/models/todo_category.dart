class TodoCategory {
  final int? id;
  final String title;

  TodoCategory({this.id, required this.title});

  factory TodoCategory.fromJson(Map<String, dynamic> json) {
    return TodoCategory(id: json['id'], title: json['title']);
  }

  Map<String, dynamic> toJson() {
    return {'title': title};
  }
}
