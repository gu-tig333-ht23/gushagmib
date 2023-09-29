class TodoItem {
  String _text;
  String _id;
  bool _isDone;
  //ToDoItem(this._text);
  TodoItem(this._text, [this._id = "", this._isDone = false]);

  factory TodoItem.fromJson(Map<String, dynamic> json) {
    String text = json['title'];
    String id = json['id'];
    bool isDone = json['done'];
    return TodoItem(text, id, isDone);
  }

  set done(bool value) => _isDone = value;
  bool get isDone => _isDone;

  String get id => _id;

  set text(String value) => _text = value;
  String get text => _text;

  // Convert to json
  Map<String, dynamic> toJson() {
    return {
      "id": _id,
      "title": _text,
      "done": _isDone,
    };
  }

  void updateIsDone() {
    if (_isDone) {
      // Set to false since user tapped box
      _isDone = false;
    } else {
      _isDone = true;
    }
  }
}
