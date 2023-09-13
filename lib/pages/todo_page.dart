import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Widgets
import 'todo_page_widgets.dart';
// Themes
import '../themes/light_purple_theme.dart';
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
    return ChangeNotifierProvider(
        create: (context) => TaskCollectionController(),
        child: MaterialApp(
          title: 'My todo list',
          theme: lightTheme(),
          home: MainPage(),
          debugShowCheckedModeBanner: false,
        ));
  }
}

class MainPage extends StatelessWidget {
  MainPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var controller = context.watch<TaskCollectionController>();
    return Scaffold(
      appBar: MainPageAppBar(),
      body: ListView(
        // Spawn the cards for the todo view
        children:
            controller.taskList.map((item) => TodoCard(item: item)).toList(),
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
      actions: [PopUpMenu()],
      title: Center(
        child: Text(
          "My to-do list",
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
