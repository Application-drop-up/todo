class Task {
  final String id;
  final String title;
  final String description;
  final DateTime? dueDate;

  Task({
    required this.id,
    required this.title,
    required this.description,
    this.dueDate,
  });
}