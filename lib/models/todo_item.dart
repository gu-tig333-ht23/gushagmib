class ToDoItem {
  String _text;
  String _id;
  bool _isDone;

  //ToDoItem(this._text);
  ToDoItem(this._text, [this._id = "", this._isDone = false]);

  factory ToDoItem.fromJson(Map<String, dynamic> json) {
    return ToDoItem(json['id'], json['title'], json['done']);
  }

  set done(bool value) => _isDone = value;
  bool get isDone => _isDone;
  String get id => _id;
  String get getText => _text;

  // Convert to json
  Map<String, dynamic> toJson() {
    return {
      "id": _id,
      "title": _text,
      "done": _isDone,
    };
  }
}
