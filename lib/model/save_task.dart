import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:mytodo/model/task_model.dart';

class SaveTask extends ChangeNotifier {
  Box<Task> get tasksBox => Hive.box<Task>('tasks');

  SaveTask() {
    _initializeTasks();
  }

  // Method to add a task
  void addTask(Task task) {
    tasksBox.add(task);
    notifyListeners();
  }

  // Method to update a task
  void updateTask(Task task) {
    task.save();
    notifyListeners();
  }

  // Method to remove a task
  void removeTask(Task task) {
    task.delete();
    notifyListeners();
  }

  // Method to initialize default tasks if no tasks are present
  Future<void> _initializeTasks() async {
    if (tasksBox.isEmpty) {
      // Add default tasks here
      final defaultTasks = [
        Task(
          title: 'Drink Water',
          isCompleted: false,
          id: DateTime.now().millisecondsSinceEpoch,
        ),
        Task(
          title: 'Charge Laptop',
          isCompleted: true,
          id: DateTime.now().millisecondsSinceEpoch,
        ),
      ];

      for (var task in defaultTasks) {
        tasksBox.add(task);
      }
    }
  }
}
