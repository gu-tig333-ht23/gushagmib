import 'package:flutter/widgets.dart';
import '../models/todo_item.dart';
import '../models/enums.dart';
import '../apis/todo_api.dart';

class TaskCollectionState with ChangeNotifier {
  // Store a reference to where we fetch data
  List<ToDoItem> _taskCollection = [];
  // Latest removed task from the collection,
  //used to show snackbar if user deleted wrong.
  ToDoItem? _lastRemovedTask;

  // Keep track of the previous variabel
  MenuOption? _previousOperation = MenuOption.all;
  ISort _sort = AllTasksSort();

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

  void setSort(MenuOption option) {
    var notPrevious = option != _previousOperation;
    if (notPrevious) {
      _previousOperation = option;
      if (option == MenuOption.all) {
        // Take all of the items regardless of done.
        _sort = AllTasksSort();
      } else if (option == MenuOption.done) {
        _sort = DoneTasksSort();
      } else if (option == MenuOption.undone) {
        _sort = UnDoneTaskSort();
      }
      // Only want to notify listeners when we update the options.
      notifyListeners();
    }
  }

  Future<void> updateTodoItem(ToDoItem item) async {
    await TodoAPI.update(item);
    if (_previousOperation != MenuOption.all) {
      // Notify if we have changed option
      notifyListeners();
    }
  }

  List<ToDoItem> get taskList => _sort.getSortedTasks(_taskCollection);
}

// Adaption of the strategy pattern
abstract class ISort {
  List<ToDoItem> getSortedTasks(List<ToDoItem> list);
}

class AllTasksSort implements ISort {
  @override
  List<ToDoItem> getSortedTasks(List<ToDoItem> tasks) {
    return tasks;
  }
}

class DoneTasksSort implements ISort {
  @override
  List<ToDoItem> getSortedTasks(List<ToDoItem> tasks) {
    return tasks.where((task) => task.isDone).toList();
  }
}

class UnDoneTaskSort implements ISort {
  @override
  List<ToDoItem> getSortedTasks(List<ToDoItem> tasks) {
    List<ToDoItem> unDoneTasks = [];
    for (int i = 0; i < tasks.length; i++) {
      ToDoItem task = tasks[i];
      if (!task.isDone) {
        unDoneTasks.add(task);
      }
    }
    return unDoneTasks;
  }
}
