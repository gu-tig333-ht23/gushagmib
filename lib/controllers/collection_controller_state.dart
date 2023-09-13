import 'package:flutter/widgets.dart';
import '../models/task_collection.dart';
import '../models/todo_item.dart';
import '../models/enums.dart';

class TaskCollectionController with ChangeNotifier {
  // Store a reference to where we fetch data
  final _collection = TaskCollection();
  static final _controller = TaskCollectionController._internal();
  MenuOption? _previousOperation = MenuOption.all;
  // Using singleton pattern to allow one controller only
  factory TaskCollectionController() {
    return _controller;
  }
  TaskCollectionController._internal();

  void add(String desc) {
    _collection.add(ToDoItem(desc));
    notifyListeners();
  }

  void remove(ToDoItem item) {
    _collection.remove(item);
    notifyListeners();
  }

  void setOperation(MenuOption option) {
    var notPrevious = option != _previousOperation;
    if (notPrevious) {
      _previousOperation = option;
      if (option == MenuOption.all) {
        _collection.sort = AllTasksSort();
      } else if (option == MenuOption.done) {
        _collection.sort = DoneTasksSort();
      } else if (option == MenuOption.undone) {
        _collection.sort = UnDoneTaskSort();
      }
    }
    // Only want to notify listeners when we update the options.
    notifyListeners();
  }

  List<ToDoItem> get taskList => _collection.sortedTasks;
}
