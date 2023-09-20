import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/controllers/theme_controller.dart';
// Widgets
import 'pages/todo_page_widgets.dart';
import 'controllers/collection_state.dart';
// Models

void main() {
  // Initiate tasks
  TaskCollectionState().fetchTasks();
  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TaskCollectionState>(
          create: (_) => TaskCollectionState(),
        ),
        ChangeNotifierProvider<ThemeController>(
          create: (_) => ThemeController(),
        ),
      ],
      // Add listener for toggling darkmode
      child: Consumer<ThemeController>(builder: (_, controller, child) {
        return MaterialApp(
          title: 'TodoHub',
          theme: controller.theme,
          home: MainPage(),
          debugShowCheckedModeBanner: false,
        );
      }),
    );
  }
}
