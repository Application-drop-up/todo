class Task {
  final String id;
  final String title;
  final String content;
  final DateTime? dueDate;
  final bool isCompleted;

  Task({
    required this.id,
    required this.title,
    required this.content,
    this.dueDate,
    required this.isCompleted,
  });
}