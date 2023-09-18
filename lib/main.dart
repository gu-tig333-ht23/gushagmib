import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/controllers/theme_controller.dart';
// Widgets
import 'pages/todo_page_widgets.dart';

// Models
import 'controllers/collection_controller_state.dart';

void main() {
  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TaskCollectionController>(
          create: (_) => TaskCollectionController(),
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
