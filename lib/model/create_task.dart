class CreateTask
{
  int? id;
  String title;
  String description;
  bool isCompleted;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? completedAt;

  CreateTask({
    this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.createdAt,
    required this.updatedAt,
    this.completedAt
  });
}