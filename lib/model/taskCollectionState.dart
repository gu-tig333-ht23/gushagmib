import 'package:flutter/material.dart';
import '../TodoItem.dart';

class TaskCollectionState with ChangeNotifier {
  final List<ToDoItem> _taskList = [];

  void addTask(String desc) {
    // If we have no description then just return without adding.
    if (desc.isEmpty) {
      return;
    }
    _taskList.add(ToDoItem(desc));
    notifyListeners();
  }

  void removeTask(ToDoItem task) {
    _taskList.remove(task);
    notifyListeners();
  }

  List<ToDoItem> get taskList => _taskList;
}

// Adaption of the strategy pattern
abstract class ISort {
  List<ToDoItem> getList(List<ToDoItem> list);
}

class AllTasksSort implements ISort {
  @override
  List<ToDoItem> getList(List<ToDoItem> list) {
    return list;
  }
}

class DoneTasksSort implements ISort {
  @override
  List<ToDoItem> getList(List<ToDoItem> tasks) {
    List<ToDoItem> doneTasks = [];
    for (int i = 0; i < tasks.length; i++) {
      ToDoItem task = tasks[i];
      if (task.isDone) {
        tasks.add(task);
      }
    }
    return doneTasks;
  }
}

class UnDoneTaskSort implements ISort {
  @override
  List<ToDoItem> getList(List<ToDoItem> tasks) {
    List<ToDoItem> unDoneTasks = [];
    for (int i = 0; i < tasks.length; i++) {
      ToDoItem task = tasks[i];
      if (!task.isDone) {
        tasks.add(task);
      }
    }
    return unDoneTasks;
  }
}
