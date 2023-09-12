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

  List<ToDoItem> getFinishedTaskList() {
    List<ToDoItem> taskList = [];
    for (int i = 0; i < _taskList.length; i++) {
      ToDoItem task = _taskList[i];
      if (task.isDone) {
        _taskList.add(task);
      }
    }
    return taskList;
  }

  List<ToDoItem> getUnDoneTaskList() {
    List<ToDoItem> taskList = [];
    for (int i = 0; i < _taskList.length; i++) {
      ToDoItem task = _taskList[i];
      if (!task.isDone) {
        _taskList.add(task);
      }
    }
    return taskList;
  }

  List<ToDoItem> get taskList => _taskList;
}
