import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/view/components/create/title_input.dart';
import 'package:todo/view/components/create/content_input.dart';
import 'package:todo/view/components/create/deadline_input.dart';
import 'package:todo/viewmodel/create_task_viewmodel.dart';
import 'package:todo/model/create_task.dart';

class CreateTaskPage extends StatelessWidget {
  const CreateTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CreateTaskViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Task'),
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
        ),
        body: Consumer<CreateTaskViewModel>(
          builder: (context, viewModel, child) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleInput(
                      controller: viewModel.titleController,  // ✅ 変更
                      hintText: 'Write down the title',
                      title: 'Title',
                      onChanged: viewModel.updateTitle,
                    ),
                    if (viewModel.hasAttemptedSubmission && viewModel.validateTitle() != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          viewModel.validateTitle()!,
                          style: const TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                    const SizedBox(height: 12),

                    ContentInput(
                      controller: viewModel.descriptionController,  // ✅ 変更
                      onChanged: viewModel.updateDescription,
                    ),
                    if (viewModel.hasAttemptedSubmission && viewModel.validateDescription() != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          viewModel.validateDescription()!,
                          style: const TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                    const SizedBox(height: 12),

                    DeadlinePicker(
                      selectedDate: viewModel.dueDate,
                      onDateSelected: viewModel.updateDueDate,
                    ),
                    if (viewModel.hasAttemptedSubmission && viewModel.validateDueDate() != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          viewModel.validateDueDate()!,
                          style: const TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                    const SizedBox(height: 20),

                    Center(
                      child: ElevatedButton(
                        key: const Key('create_task_button'),
                        onPressed: () {
                          viewModel.attemptSubmit();
                          if (viewModel.canSubmit()) {
                            CreateTask newTask = viewModel.createTask();
                            Navigator.pop(context, newTask);
                          }
                        },
                        child: const Text("Create"),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
