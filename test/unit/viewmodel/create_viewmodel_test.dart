import 'package:flutter_test/flutter_test.dart';
import 'package:todo/viewmodel/create_task_viewmodel.dart';

void main() {
  group('CreateTaskViewModel Validation Tests', () {
    late CreateTaskViewModel viewModel;

    setUp(() {
      viewModel = CreateTaskViewModel();
    });

    test('タイトルが空のときはエラーメッセージを返す', () {
      expect(viewModel.validateTitle(), "title is required");
    });

    test('タイトルが3文字未満のときはエラーメッセージを返す', () {
      expect(viewModel.validateTitle("ab"), "title must be at least 3 characters long");
    });

    test('タイトルが3文字以上のときはエラーなし', () {
      expect(viewModel.validateTitle("Task"), null);
    });

    test('説明が空のときはエラーメッセージを返す', () {
      expect(viewModel.validateDescription(""), "content is required");
    });

    test('説明が6文字未満のときはエラーメッセージを返す', () {
      expect(viewModel.validateDescription("short"), "content must be at least 6 characters long");
    });

    test('説明が6文字以上のときはエラーなし', () {
      expect(viewModel.validateDescription("Valid description"), null);
    });

    test('期限日が過去の場合はエラーメッセージを返す', () {
      DateTime pastDate = DateTime.now().subtract(Duration(days: 1));
      expect(viewModel.validateDueDate(pastDate), "deadline cannot be in the past");
    });

    test('期限日が未来の場合はエラーなし', () {
      DateTime futureDate = DateTime.now().add(Duration(days: 1));
      viewModel.updateDueDate(futureDate); // **セットしておく**
      expect(viewModel.validateDueDate(), null); // **引数なしでもOK**
    });

    test('期限日がnullの場合はエラーメッセージを返す', () {
      expect(viewModel.validateDueDate(), "deadline is required");
    });
  });
}
