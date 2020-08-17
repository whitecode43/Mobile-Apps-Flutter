import 'task.dart';
import 'package:flutter/foundation.dart';
import 'dart:collection';

class TaskData extends ChangeNotifier {
  List<Task> tasks = [
    Task(task: 'this is first task'),
    Task(task: 'this is second task'),
    Task(task: 'this is third task'),
  ];
  int get taskCount {
    return tasks.length;
  }

  void addTask(String task) {
    tasks.add(Task(task: task));
    notifyListeners();
  }

  void update(Task task) {
    task.toggleState();
    notifyListeners();
  }

  void deleteTask(Task taskTodelete) {
    tasks.remove(taskTodelete);
    notifyListeners();
  }
}
