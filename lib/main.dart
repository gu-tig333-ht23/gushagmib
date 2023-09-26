import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/controllers/theme_state.dart';
// Widgets
import 'pages/todo_page.dart';
import 'controllers/collection_state.dart';
// Models

void main() {
  final taskCollection = TaskCollectionState();
  taskCollection.fetchTasks();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<TaskCollectionState>(
        create: (_) => taskCollection,
      ),
      ChangeNotifierProvider<ThemeState>(
        create: (_) => ThemeState(),
      ),
    ],
    // Add listener for toggling darkmode
    child: Consumer<ThemeState>(builder: (_, controller, child) {
      return MaterialApp(
        title: 'TodoHub',
        theme: controller.theme,
        home: MainPage(),
        debugShowCheckedModeBanner: false,
      );
    }),
  ));
}
