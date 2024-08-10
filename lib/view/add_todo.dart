import 'package:flutter/material.dart';
import 'package:mytodo/model/save_task.dart';
import 'package:mytodo/model/task_model.dart';
import 'package:provider/provider.dart';

class AddTodo extends StatelessWidget {
  AddTodo({super.key, required this.title});
  final String title;

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter your task',
                prefixIcon: const Icon(Icons.task),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _controller.clear();
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_controller.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter a task.'),
                    ),
                  );
                } else {
                  context.read<SaveTask>().addTask(
                        Task(
                          id: DateTime.now()
                              .millisecondsSinceEpoch, // Generating a unique ID
                          title: _controller.text.trim(),
                          isCompleted: false,
                        ),
                      );
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
              ),
              child: const Text(
                'Add Task',
                style: TextStyle(color: Colors.white, letterSpacing: 2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
