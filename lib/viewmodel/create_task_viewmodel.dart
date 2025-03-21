import 'package:flutter/material.dart';
import 'package:todo/model/create_task.dart';

class CreateTaskViewModel extends ChangeNotifier {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  DateTime? dueDate;
  bool isCompleted = false;
  bool hasAttemptedSubmission = false;

  String get title => titleController.text;
  String get description => descriptionController.text;

  void updateTitle(String newTitle) {
    titleController.text = newTitle;
    notifyListeners();
  }

  void updateDescription(String newDescription) {
    descriptionController.text = newDescription;
    notifyListeners();
  }

  void updateDueDate(DateTime? newDueDate) {
    dueDate = newDueDate;
    hasAttemptedSubmission = true;
    notifyListeners();
  }

  // ✅ validateTitle() に引数を追加
  String? validateTitle([String? inputTitle]) {
    final checkTitle = inputTitle ?? title;
    if (checkTitle.isEmpty) return "title is required";
    if (checkTitle.length < 3) return "title must be at least 3 characters long";
    return null;
  }

  // ✅ validateDescription() に引数を追加
  String? validateDescription([String? inputDescription]) {
    final checkDescription = inputDescription ?? description;
    if (checkDescription.isEmpty) return "content is required";
    if (checkDescription.length < 6) return "content must be at least 6 characters long";
    return null;
  }

  // ✅ validateDueDate() に引数を追加
  String? validateDueDate([DateTime? inputDate]) {
    final checkDate = inputDate ?? dueDate;
    if (checkDate == null) return "deadline is required";
    if (checkDate.isBefore(DateTime.now())) return "deadline cannot be in the past";
    return null;
  }

  bool canSubmit() {
    return validateTitle() == null &&
        validateDescription() == null &&
        validateDueDate() == null;
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
