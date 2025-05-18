class TodoModel {
  late String? id;
  late String text;
  late bool isCompleted;

  TodoModel({this.id, required this.text, this.isCompleted = false});

  TodoModel toggleCompletion() {
    return TodoModel(id: id, text: text, isCompleted: !isCompleted);
  }

  Map<String, dynamic> toJson() {
    return {'text': text, 'isCompleted': isCompleted};
  }

  TodoModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    text = json['text'];
    isCompleted = json['isCompleted'] ?? false;
  }
}
