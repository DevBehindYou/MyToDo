import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mytodo/model/save_task.dart';
import 'package:mytodo/model/task_model.dart';
import 'package:provider/provider.dart';
import 'package:mytodo/theme/theme_provider.dart';
import 'package:mytodo/view/todo_list.dart';
import 'package:mytodo/view/add_todo.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox('themeBox');
  await Hive.openBox<Task>('tasks');

  final themeProvider = ThemeProvider();
  await themeProvider.loadTheme();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: themeProvider),
        ChangeNotifierProvider(
          create: (context) => SaveTask(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeProvider.themeData,
          initialRoute: '/',
          routes: {
            '/': (_) => const MyHomePage(title: 'MyToDo'),
            '+/': (_) => AddTodo(title: 'Add ToDo'),
          },
        );
      },
    );
  }
}
