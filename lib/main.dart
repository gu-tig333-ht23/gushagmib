import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/controllers/theme_controller.dart';
// Widgets
import 'pages/todo_page.dart';
import 'controllers/collection_state.dart';
// Models

void main() {
  final _taskCollection = TaskCollectionState();
  _taskCollection.fetchTasks();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<TaskCollectionState>(
        create: (_) => _taskCollection,
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
  ));
}
