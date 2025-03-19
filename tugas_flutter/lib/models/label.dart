class Label {
  final int? id;
  final String title;

  Label({this.id, required this.title});

  factory Label.fromJson(Map<String, dynamic> json) {
    return Label(id: json['id'], title: json['title']);
  }

  Map<String, dynamic> toJson() {
    return {'title': title};
  }
}
