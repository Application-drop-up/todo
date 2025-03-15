class CreateTask
{
  int? id;
  String title;
  String description;
  bool isCompleted;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? completedAt;
  DateTime? dueDate;

  CreateTask({
    this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.createdAt,
    required this.updatedAt,
    this.completedAt,
    this.dueDate
  }) {
    if (title.isEmpty) {
      throw ArgumentError('title cannot be empty');
    } else if (description.isEmpty) {
      throw ArgumentError('content cannot be empty');
    }
    if (title.length < 3) {
      throw ArgumentError('title must be at least 3 characters long');
    } else if (description.length < 6) {
      throw ArgumentError('content must be at least 3 characters long');
    }
    if (dueDate!.isBefore(DateTime.now())) {
      throw ArgumentError('due date must be in the future');
    }
  }
}