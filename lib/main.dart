import 'package:flutter/material.dart';
import 'addItemPage.dart';

void main() {
  runApp(const ToDoApp());
}

class ToDoItem {
  String _text;
  bool _isDone = false;

  ToDoItem(this._text);

  String getText() {
    return _text;
  }

  void setBool(bool isDone) {
    _isDone = isDone;
  }

  bool getBool() {
    return _isDone;
  }
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My todo list',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 68, 252, 68)),
        useMaterial3: true,
      ),
      home: MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainPage extends StatelessWidget {
  MainPage({
    super.key,
  });

  final items = [
    ToDoItem("Lorem Ipsum 1"),
    ToDoItem("Lorem Ipsum 2"),
    ToDoItem("Lorem Ipsum 3"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainPageAppBar(),
      body: ListView(
        children: items.map((item) => TodoCard(item: item)).toList(),
      ),
      floatingActionButton: AddTodoItemButton(),
    );
  }
}

class MainPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainPageAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      title: Center(
        child: Text(
          "My to-do list",
        ),
      ),
      actions: <Widget>[
        PopupMenuButton(
          icon: const Icon(Icons.more_vert),
          itemBuilder: (context) => <PopupMenuEntry>[
            const PopupMenuItem(child: Text("all")),
            const PopupMenuItem(child: Text("done")),
            const PopupMenuItem(child: Text("undone")),
          ],
        ),
      ],
      backgroundColor: theme.colorScheme.primary,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class TodoCard extends StatelessWidget {
  const TodoCard({super.key, required this.item});

  final ToDoItem item;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: IconButton(
              onPressed: () => {},
              icon: Icon(
                Icons.check_box_outline_blank,
              ),
            ),
            title: Text(item.getText()),
            trailing: IconButton(
                onPressed: () => {
                      // Remove todo
                      print(item._isDone)
                    },
                icon: Icon(Icons.close)),
          ),
        ],
      ),
    );
  }
}

class AddTodoItemButton extends StatelessWidget {
  const AddTodoItemButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const AddToDoItemPage()),
        ),
      },
      tooltip: 'Add to-do item',
      child: const Icon(Icons.add),
    );
  }
}
