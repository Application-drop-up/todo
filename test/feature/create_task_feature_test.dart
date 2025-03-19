import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:todo/view/create_task_view.dart';
import 'package:todo/viewmodel/create_task_viewmodel.dart';

void main() {
  group('Create Task Feature Test', () {
    testWidgets('画面が正常に表示されること', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider(
            create: (context) => CreateTaskViewModel(),
            child: CreateTaskPage(),
          ),
        ),
      );

      // Title, Content, Deadline, Createボタンが表示されているか
      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Write down the title'), findsOneWidget);
      expect(find.text('Create'), findsOneWidget);
    });

    testWidgets('空のまま作成するとバリデーションエラーが表示される', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider(
            create: (context) => CreateTaskViewModel(),
            child: CreateTaskPage(),
          ),
        ),
      );

      await tester.tap(find.text('Create'));
      await tester.pumpAndSettle(); // UIの更新を待つ

      // バリデーションメッセージが表示されることを確認
      expect(find.text('title is required'), findsOneWidget);
      expect(find.text('content is required'), findsOneWidget);
      expect(find.text('deadline is required'), findsOneWidget);
    });

    testWidgets('正しく入力するとタスクが作成される', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider(
            create: (context) => CreateTaskViewModel(),
            child: CreateTaskPage(),
          ),
        ),
      );

      // タイトルを入力
      await tester.enterText(find.byType(TextField).first, 'New Task');
      await tester.pump();

      // 内容を入力
      await tester.enterText(find.byType(TextField).last, 'This is a test task.');
      await tester.pump();

      // 期限を選択（カレンダーが開けないため、直接ViewModelを更新）
      final viewModel = Provider.of<CreateTaskViewModel>(tester.element(find.byType(CreateTaskPage)), listen: false);
      viewModel.updateDueDate(DateTime.now().add(Duration(days: 1)));
      await tester.pump();

      // 作成ボタンを押す
      await tester.tap(find.text('Create'));
      await tester.pumpAndSettle();

      // エラーが表示されていないことを確認
      expect(find.text('title is required'), findsNothing);
      expect(find.text('content is required'), findsNothing);
      expect(find.text('deadline is required'), findsNothing);

      // 画面が閉じる（popされる）ことを確認
      expect(find.byType(CreateTaskPage), findsNothing);
    });
  });
}
