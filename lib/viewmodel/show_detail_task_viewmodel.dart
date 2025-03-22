import 'package:flutter/material.dart';
import 'package:todo/model/show_detail_task.dart';

class ShowDetailTaskViewModel extends ChangeNotifier {
  final List<Task> _tasks = [
    Task(
        id: "1",
        title: "Task 1",
        content: "Description 1",
        dueDate: DateTime(2025, 5, 10),
        isCompleted: false,
    ),
    Task(
        id: "2",
        title: "Task 2",
        content: "Description 2",
        dueDate: DateTime(2025, 6, 15),
        isCompleted: false,
    ),
  ];

  List<Task> get tasks => _tasks;

  Task? getTaskById(String id) {
    return _tasks.firstWhere(
          (task) => task.id == id,
      orElse: () => Task(id: '', title: 'Not Found', content: 'No description available', dueDate: null, isCompleted: false),
    );
  }
}