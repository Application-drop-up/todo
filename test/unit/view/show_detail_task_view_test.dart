import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:todo/view/show_detail_task_view.dart';
import 'package:todo/viewmodel/show_detail_task_viewmodel.dart';
import 'package:todo/model/show_detail_task.dart';

void main() {
  group('ShowTaskPage Widget Test', () {
    late Task sampleTask;

    setUp(() {
      sampleTask = Task(
        id: "1",
        title: "Sample Task",
        content: "This is a sample task for testing.",
        dueDate: DateTime(2025, 5, 10),
        isCompleted: false,
      );
    });

    testWidgets('displays task details correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider(
            create: (context) => ShowDetailTaskViewModel(task: sampleTask),
            child: ShowTaskPage(task: sampleTask),
          ),
        ),
      );

      // タイトルが表示されているか
      expect(find.text("Sample Task"), findsOneWidget);

      // コンテンツが表示されているか
      expect(find.text("This is a sample task for testing."), findsOneWidget);

      // 期日が正しく表示されているか
      expect(find.text("Due Date: ${sampleTask.dueDate.toString()}"), findsOneWidget);

      // `isCompleted` の表示が正しいか
      expect(find.text("Status: not yet"), findsOneWidget);
    });

    testWidgets('displays "done" when task is completed', (WidgetTester tester) async {
      Task completedTask = Task(
        id: "2",
        title: "Completed Task",
        content: "This task is completed.",
        dueDate: DateTime(2025, 6, 15),
        isCompleted: true, // ✅ 完了済みのタスク
      );

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider(
            create: (context) => ShowDetailTaskViewModel(task: completedTask),
            child: ShowTaskPage(task: completedTask),
          ),
        ),
      );

      // `isCompleted` が true の場合、"done" が表示されているか
      expect(find.text("Status: done"), findsOneWidget);
    });
  });
}
