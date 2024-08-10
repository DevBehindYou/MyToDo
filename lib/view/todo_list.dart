import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mytodo/model/save_task.dart';
import 'package:mytodo/model/task_model.dart';
import 'package:mytodo/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final saveTaskProvider = Provider.of<SaveTask>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return Switch(
                  activeColor: Colors.white,
                  inactiveThumbColor: Colors.white,
                  thumbColor: WidgetStatePropertyAll(
                    Provider.of<ThemeProvider>(context).isDarkMode
                        ? Colors.white
                        : Colors.orange.shade400,
                  ),
                  activeTrackColor: Colors.black,
                  inactiveTrackColor: Colors.transparent,
                  thumbIcon: WidgetStateProperty.all(
                    themeProvider.isDarkMode
                        ? const Icon(Icons.nights_stay)
                        : const Icon(Icons.sunny),
                  ),
                  value: Provider.of<ThemeProvider>(context).isDarkMode,
                  onChanged: (value) {
                    themeProvider.toggleTheme();
                  },
                );
              },
            ),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: saveTaskProvider.tasksBox.listenable(),
        builder: (BuildContext context, Box<Task> box, Widget? child) {
          if (box.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  child: const Center(child: Text('No tasks found')),
                ),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: box.length,
              itemBuilder: (BuildContext context, index) {
                final task = box.getAt(index)!;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListTile(
                      title: Text(
                        task.title,
                        style: TextStyle(
                          decoration: task.isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      trailing: Wrap(
                        children: [
                          Checkbox(
                            value: task.isCompleted,
                            onChanged: (value) {
                              setState(() {
                                task.isCompleted = value ?? false;
                                saveTaskProvider.updateTask(task);
                              });
                              if (task.isCompleted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Task completed! Yuhu..'),
                                    duration: Duration(milliseconds: 600),
                                  ),
                                );
                              }
                            },
                          ),
                          IconButton(
                            onPressed: () {
                              saveTaskProvider.removeTask(task);
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '+/');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
