class ToDoItem {
  final String _text;
  bool _isDone = false;

  ToDoItem(this._text);

  String getText() {
    return _text;
  }

  void setBool(bool isDone) {
    _isDone = isDone;
  }

  bool getBool() {
    return _isDone;
  }
}
