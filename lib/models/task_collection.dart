import 'todo_item.dart';

class TaskCollection {
  final List<ToDoItem> _taskList = [];
  // Default sort strategy is all tasks.
  ISort _sort = AllTasksSort();

  void add(ToDoItem task) {
    _taskList.add(task);
  }

  void remove(ToDoItem task) {
    _taskList.remove(task);
  }

  // Setter for sort.
  set sort(strat) => _sort = strat;

  // Depending on the sorting strategy, we either return
  // all tasks or done / undone tasks
  List<ToDoItem> get sortedTasks => _sort.getSortedTasks(_taskList);
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
    List<ToDoItem> doneTasks = [];
    for (int i = 0; i < tasks.length; i++) {
      ToDoItem task = tasks[i];
      if (task.isDone) {
        doneTasks.add(task);
      }
    }
    return doneTasks;
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
