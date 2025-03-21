import 'package:flutter_test/flutter_test.dart';
import 'package:todo/model/create_task.dart';
void main() {
  group('CreateTask Model Validation Tests', () {
    test('Valid task should be created successfully', () {
      DateTime now = DateTime.now();
      DateTime futureDate = now.add(Duration(days: 1));

      expect(() {
        CreateTask(
          title: 'Valid Title',
          description: 'Valid description content',
          isCompleted: false,
          createdAt: now,
          updatedAt: now,
          dueDate: futureDate,
        );
      }, returnsNormally);
    });

    test('Title cannot be empty', () {
      DateTime now = DateTime.now();
      DateTime futureDate = now.add(Duration(days: 1));

      expect(() {
        CreateTask(
          title: '',
          description: 'Valid description',
          isCompleted: false,
          createdAt: now,
          updatedAt: now,
          dueDate: futureDate,
        );
      }, throwsArgumentError);
    });

    test('Description cannot be empty', () {
      DateTime now = DateTime.now();
      DateTime futureDate = now.add(Duration(days: 1));

      expect(() {
        CreateTask(
          title: 'Valid Title',
          description: '',
          isCompleted: false,
          createdAt: now,
          updatedAt: now,
          dueDate: futureDate,
        );
      }, throwsArgumentError);
    });

    test('Title must be at least 3 characters long', () {
      DateTime now = DateTime.now();
      DateTime futureDate = now.add(Duration(days: 1));

      expect(() {
        CreateTask(
          title: 'ab',
          description: 'Valid description',
          isCompleted: false,
          createdAt: now,
          updatedAt: now,
          dueDate: futureDate,
        );
      }, throwsArgumentError);
    });

    test('Description must be at least 6 characters long', () {
      DateTime now = DateTime.now();
      DateTime futureDate = now.add(Duration(days: 1));

      expect(() {
        CreateTask(
          title: 'Valid Title',
          description: 'abc',
          isCompleted: false,
          createdAt: now,
          updatedAt: now,
          dueDate: futureDate,
        );
      }, throwsArgumentError);
    });

    test('Due date must be in the future', () {
      DateTime now = DateTime.now();
      DateTime pastDate = now.subtract(Duration(days: 1));

      expect(() {
        CreateTask(
          title: 'Valid Title',
          description: 'Valid description',
          isCompleted: false,
          createdAt: now,
          updatedAt: now,
          dueDate: pastDate,
        );
      }, throwsArgumentError);
    });
  });
}




