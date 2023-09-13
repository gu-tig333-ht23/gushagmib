import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/controllers/theme_controller.dart';
// Widgets
import 'todo_page_widgets.dart';
import 'toggle_theme.dart';

// Models
import '../controllers/collection_controller_state.dart';

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

class MainPage extends StatelessWidget {
  MainPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var controller = context.watch<TaskCollectionController>();
    var tasks = controller.taskList;

    return Scaffold(
      appBar: MainPageAppBar(),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return Column(
            // Set a dividing line on top if index is 0 else below.
            children: index == 0
                ? <Widget>[
                    Divider(
                      height: 1,
                    ),
                    TodoTile(item: tasks[index]),
                    Divider(height: 0),
                  ]
                : <Widget>[
                    TodoTile(item: tasks[index]),
                    Divider(height: 0),
                  ],
          );
        },
      ),
      floatingActionButton: AddTodoItemButton(),
    );
  }
}

class MainPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  MainPageAppBar({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        ToggleDarkTheme(),
        PopUpMenu(),
      ],
      title: Center(
        child: Text(
          "TodoHub",
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
