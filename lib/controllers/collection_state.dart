import 'package:flutter/widgets.dart';
import '../models/todo_item.dart';
import '../models/enums.dart';
import '../apis/todo_api.dart';
import '../models/task_collection.dart';
import 'package:http/http.dart' as http;

class TaskCollectionState with ChangeNotifier {
  // Store a reference to where we fetch data
  final _collection = TaskCollection();
  List<ToDoItem> _taskCollection = [];
  static final _controller = TaskCollectionState._internal();
  // Latest removed task from the collection,
  //used to show snackbar if user deleted wrong.
  ToDoItem? _lastRemovedTask;

  // Keep track of the previous variabel
  MenuOption? _previousOperation = MenuOption.all;
  // Using singleton pattern to allow one controller only
  factory TaskCollectionState() {
    return _controller;
  }
  TaskCollectionState._internal();

  ToDoItem? get lastRemovedTask => _lastRemovedTask;

  void fetchTasks() async {
    var taskCollection = await TodoAPI.fetchTodoItems();
    _taskCollection = taskCollection;
    notifyListeners();
  }

  void add(ToDoItem task) async {
    _collection.add(task);
    await TodoAPI.add(task);
    fetchTasks();
  }

  void remove(ToDoItem item) {
    _lastRemovedTask = item;
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

  // Lets us call this method to rebuild
  // listeners when a todoItem is changed
  void updateItemList() {
    if (_previousOperation != MenuOption.all) {
      notifyListeners();
    }
  }

  List<ToDoItem> get taskList => _taskCollection;
}
