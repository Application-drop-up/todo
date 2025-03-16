import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/view/components/create/title_input.dart';
import 'package:todo/view/components/create/content_input.dart';
import 'package:todo/view/components/create/deadline_input.dart';
import 'package:todo/viewmodel/create_task_viewmodel.dart';
import 'package:todo/model/create_task.dart';

class CreateTaskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CreateTaskViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Task', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<CreateTaskViewModel>(
            builder: (context, viewModel, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleInput(
                    controller: TextEditingController(text: viewModel.title),
                    hintText: 'Write down the title',
                    title: 'Title',
                    onChanged: (value) {
                      viewModel.updateTitle(value);
                    },
                  ),
                  if (viewModel.hasAttemptedSubmission && viewModel.validateTitle(viewModel.title) != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        viewModel.validateTitle(viewModel.title)!,
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                  const SizedBox(height: 12),

                  ContentInput(
                    controller: TextEditingController(text: viewModel.description),
                    onChanged: (value) {
                      viewModel.updateDescription(value);
                    },
                  ),
                  if (viewModel.hasAttemptedSubmission && viewModel.validateDescription(viewModel.description) != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        viewModel.validateDescription(viewModel.description)!,
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                  const SizedBox(height: 12),

                  DeadlinePicker(
                    selectedDate: viewModel.dueDate,
                    onDateSelected: (date) {
                      viewModel.updateDueDate(date);
                    },
                  ),
                  if (viewModel.hasAttemptedSubmission && viewModel.validateDueDate(viewModel.dueDate) != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        viewModel.validateDueDate(viewModel.dueDate)!,
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
              );
            },
          ),
        ),
      ),
    );
  }
}
