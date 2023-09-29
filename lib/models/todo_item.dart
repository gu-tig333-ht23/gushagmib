class TodoItem {
  String _text;
  String _id;
  bool _isDone;
  int _index;
  //ToDoItem(this._text);
  TodoItem(this._text, [this._id = "", this._isDone = false, this._index = 0]);

  factory TodoItem.fromJson(Map<String, dynamic> json) {
    List parsedText = json['title'].split('{');
    String text = parsedText[0];
    String id = json['id'];
    bool isDone = json['done'];
    int index = int.parse(parsedText[1]);
    print(parsedText);
    return TodoItem(text, id, isDone, index);
  }

  set index(int value) => _index = value;
  int get index => _index;

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
