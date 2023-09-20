import 'package:flutter/widgets.dart';
import '../models/todo_item.dart';
import '../models/enums.dart';
import '../apis/todo_api.dart';

class TaskCollectionState with ChangeNotifier {
  // Store a reference to where we fetch data
  List<ToDoItem> _taskCollection = [];
  //List<ToDoItem> _sortedTasks = [];
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

  Future<void> fetchTasks() async {
    var taskCollection = await TodoAPI.fetchTodoItems();
    _taskCollection = taskCollection;
    notifyListeners();
  }

  Future<void> add(ToDoItem task) async {
    await TodoAPI.add(task);
    notifyListeners();
  }

  Future<void> remove(ToDoItem item) async {
    // save last item, in case of undoing
    _lastRemovedTask = item;
    await TodoAPI.remove(item);
    notifyListeners();
  }

  void setOperation(MenuOption option) {
    var notPrevious = option != _previousOperation;
    print("SORTING");
    if (notPrevious) {
      _previousOperation = option;
      if (option == MenuOption.all) {
        // Take all of the items regardless of done.
        _taskCollection = _taskCollection;
      } else if (option == MenuOption.done) {
        _taskCollection = _taskCollection.where((task) => task.isDone).toList();
      } else if (option == MenuOption.undone) {
        _taskCollection =
            _taskCollection.where((task) => !task.isDone).toList();
      }
    }
    fetchTasks();
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

  void updateTodoItem(String id) {}

  List<ToDoItem> get taskList => _taskCollection;
}
