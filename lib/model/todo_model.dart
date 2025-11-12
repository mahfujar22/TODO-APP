class TODOModel {
  int? id;
  String title;
  bool isCompleted;

  TODOModel({
    this.id,
    required this.title,
    required this.isCompleted,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }

  factory TODOModel.fromMap(Map<String, dynamic> map) {
    return TODOModel(
      id: map['id'],
      title: map['title'],
      isCompleted: map['isCompleted'] == 1,
    );
  }

  void toggleCompleted() {
    isCompleted = !isCompleted;
  }
}
