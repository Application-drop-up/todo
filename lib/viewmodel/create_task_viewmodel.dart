import 'package:flutter/material.dart';
import 'package:todo/model/create_task.dart';

class CreateTaskViewModel extends ChangeNotifier {
  String title = "";
  String description = "";
  DateTime? dueDate;
  bool isCompleted = false;
  bool hasAttemptedSubmission = false;

  void updateTitle(String newTitle) {
    title = newTitle;
    notifyListeners();
  }

  void updateDescription(String newDescription) {
    description = newDescription;
    notifyListeners();
  }

  void updateDueDate(DateTime? newDueDate) {
    dueDate = newDueDate;
    notifyListeners();
  }

  String? validateTitle(String? value) {
    if (value == null || value.isEmpty) return "title is required";
    if (value.length < 3) return "title must be at least 3 characters long";
    return null;
  }

  String? validateDescription(String? value) {
    if (value == null || value.isEmpty) return "content is required";
    if (value.length < 6) return "content must be at least 6 characters long";
    return null;
  }

  String? validateDueDate(DateTime? selectedDate) {
    if (selectedDate == null) return "deadline is required";
    if (selectedDate.isBefore(DateTime.now())) {
      return "deadline can not registered in the past";
    }
    return null;
  }

  bool canSubmit() {
    return validateTitle(title) == null &&
        validateDescription(description) == null &&
        validateDueDate(dueDate) == null;
  }

  void attemptSubmit() {
    hasAttemptedSubmission = true;
    notifyListeners();
  }

  CreateTask createTask() {
    if (!canSubmit()) {
      throw Exception("some fields are invalid");
    }
    return CreateTask(
      title: title,
      description: description,
      isCompleted: isCompleted,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      dueDate: dueDate,
    );
  }
}
