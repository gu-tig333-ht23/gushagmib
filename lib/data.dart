class ToDoItem {
  final String _text;
  bool _isDone = false;

  ToDoItem(this._text);

  String getText() {
    return _text;
  }

  void setIsDone(bool isDone) {
    _isDone = isDone;
  }

  bool getIsDone() {
    return _isDone;
  }
}
