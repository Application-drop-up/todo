import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:todo/view/create_task_view.dart';
import 'package:todo/viewmodel/create_task_viewmodel.dart';

void main() {
  testWidgets('CreateTaskPage renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (context) => CreateTaskViewModel(),
          child: CreateTaskPage(),
        ),
      ),
    );

    expect(find.text('Title'), findsOneWidget);

    expect(find.text('Create Task'), findsOneWidget);
  });

  testWidgets('Validation errors are displayed when submitting empty fields', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (context) => CreateTaskViewModel(),
          child: CreateTaskPage(),
        ),
      ),
    );

    expect(find.descendant(
      of: find.byType(AppBar),
      matching: find.text('Create Task'),
    ), findsOneWidget);

    await tester.tap(find.byKey(const Key('create_task_button')));
    await tester.pumpAndSettle();

    expect(find.text('title is required'), findsOneWidget);
    expect(find.text('content is required'), findsOneWidget);
    expect(find.text('deadline is required'), findsOneWidget);
  });

  testWidgets('Can enter title and content, and select deadline', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (context) => CreateTaskViewModel(),
          child: CreateTaskPage(),
        ),
      ),
    );

    await tester.enterText(find.byType(TextField).first, 'Test Task');
    await tester.pump();

    await tester.enterText(find.byType(TextField).last, 'This is a test task.');
    await tester.pump();

    expect(find.text('Test Task'), findsOneWidget);
    expect(find.text('This is a test task.'), findsOneWidget);
  });
}
