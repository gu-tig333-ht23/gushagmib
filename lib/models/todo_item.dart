class ToDoItem {
  final String _text;
  String _id;
  bool _isDone;

  //ToDoItem(this._text);
  ToDoItem(this._text, [this._id = "Test", this._isDone = false]);

  set done(bool value) => _isDone = value;
  bool get isDone => _isDone;
  String get id => _id;
  String get text => _text;
}
