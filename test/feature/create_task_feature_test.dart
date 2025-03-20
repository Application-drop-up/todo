import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:todo/view/create_task_view.dart';
import 'package:todo/viewmodel/create_task_viewmodel.dart';

void main() {
  testWidgets('タスク作成フォームが正しく動作する', (WidgetTester tester) async {

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (context) => CreateTaskViewModel(),
          child: const CreateTaskPage(),
        ),
      ),
    );

    final viewModel = Provider.of<CreateTaskViewModel>(
      tester.element(find.byType(CreateTaskPage)),
      listen: false,
    );

    await tester.enterText(find.byType(TextField).at(0), 'New Task');
    viewModel.updateTitle('New Task');
    await tester.pumpAndSettle();


    await tester.enterText(find.byType(TextField).at(1), 'This is a test task.');
    viewModel.updateDescription('This is a test task.');
    await tester.pumpAndSettle();

    await tester.tap(find.byType(ListTile));
    await tester.pumpAndSettle();

    expect(find.byType(DatePickerDialog), findsOneWidget);

    final pickedDate = DateTime.now().add(const Duration(days: 2));
    viewModel.updateDueDate(pickedDate);
    await tester.pumpAndSettle();

    expect(viewModel.validateDueDate(viewModel.dueDate), isNull);


    expect(viewModel.canSubmit(), isTrue);

    await tester.ensureVisible(find.byKey(const Key('create_task_button')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('create_task_button')));
    await tester.pumpAndSettle();
  });
}
