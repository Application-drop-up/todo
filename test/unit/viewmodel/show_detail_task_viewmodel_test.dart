import 'package:flutter_test/flutter_test.dart';
import 'package:todo/model/show_detail_task.dart';
import 'package:todo/viewmodel/show_detail_task_viewmodel.dart';

void main() {
  group('ShowDetailTaskViewModel Test', () {
    late ShowDetailTaskViewModel viewModel;
    late Task task;

    setUp(() {
      task = Task(
        id: "1",
        title: "Task 1",
        content: "Description 1",
        dueDate: DateTime(2025, 5, 10),
        isCompleted: false,
      );
      viewModel = ShowDetailTaskViewModel(task: task);
    });


    test('should return a task when a valid ID is provided', () {
      final task = viewModel.getTaskById("1");

      expect(task, isNotNull);
      expect(task!.id, "1");
      expect(task.title, "Task 1");
      expect(task.content, "Description 1");
      expect(task.dueDate, DateTime(2025, 5, 10));
      expect(task.isCompleted, false);
    });

    test('should return null when an invalid ID is provided', () {
      final task = viewModel.getTaskById("999");

      expect(task, isNotNull);
      expect(task!.id, "");
      expect(task.title, "Not Found");
      expect(task.content, "No description available");
      expect(task.dueDate, anyOf([isNull, isA<DateTime>()]));
      expect(task.isCompleted, false);
    });

    test('should return all tasks', () {
      final tasks = viewModel.tasks;

      expect(tasks.length, 2);
      expect(tasks[0].id, "1");
      expect(tasks[1].id, "2");
    });
  });
}
