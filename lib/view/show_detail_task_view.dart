import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/viewmodel/show_detail_task_viewmodel.dart';
import 'package:todo/model/show_detail_task.dart';
import 'package:intl/intl.dart';

class ShowTaskPage extends StatelessWidget {
  final Task task;

  const ShowTaskPage({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ShowDetailTaskViewModel(task: task),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Task Detail'),
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
        ),
        body: Consumer<ShowDetailTaskViewModel>(
          builder: (context, viewModel, child) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      viewModel.task.title,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      viewModel.task.content ,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Due Date: ${DateFormat('yyyy-MM-dd').format(viewModel.task.dueDate ?? DateTime.now())}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Status: ${viewModel.task.isCompleted ? "done" : "not yet"}',
                      style: const TextStyle(fontSize: 16),
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