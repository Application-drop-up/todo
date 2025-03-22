import 'package:flutter/material.dart';
import 'package:todo/view/create_task_view.dart';
import 'package:todo/model/show_detail_task.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Todo App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Task> todoList = [
    Task(id: "1", title: "Task 1", content: "This is task 1", dueDate: DateTime(2025, 5, 10), isCompleted: false),
    Task(id: "2", title: "Task 2", content: "This is task 2", dueDate:  DateTime(2025, 6, 15), isCompleted: false),
    Task(id: "3", title: "Task 3", content: "This is task 3", dueDate: DateTime(2025, 7, 20), isCompleted: false),
  ];

  void _navigateToCreateTaskScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateTaskPage()),
    ).then((newTask) {
      if (newTask != null && newTask is Task) {
        setState(() {
          todoList.insert(0, newTask);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[10],
      appBar: AppBar(
        title: const Text('To do index', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton("Create", Colors.purple, _navigateToCreateTaskScreen),
                _buildActionButton("Delete All", Colors.redAccent, () {
                  setState(() {
                    todoList.clear();
                  });
                }),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todoList.length,
              itemBuilder: (context, index) {
                final task = todoList[index];

                return Card(
                  color: Colors.white,
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: ListTile(
                    title: Text(task.title, style: const TextStyle(fontSize: 18)),
                    subtitle: Text("Deadline: ${task.dueDate.toString()}"),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Task: ${task.title}\nDeadline: ${task.dueDate}")),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String text, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      child: Text(text),
    );
  }
}
