import 'package:flutter/material.dart';
import 'package:todo/view/create_task_view.dart';

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
  List<String> todoList = [
    "Task 13", "Task 12", "Task 11", "Task 10", "Task 9", "Task 8",
    "Task 7", "Task 6", "Task 5", "Task 4", "Task 3", "Task 2", "Task 1"
  ];

  void _navigateToCreateTaskScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateTaskPage()),
    ).then((newTask) {
      if (newTask != null) {
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
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todoList.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.white,
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: ListTile(
                    title: Text(todoList[index], style: const TextStyle(fontSize: 18)),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.deepPurple,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Text(
              '© 2025 Todo App',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ),
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
