import 'package:flutter/material.dart';

void main() {
  runApp(const ToDoApp());
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

  final msgs = [
    "Lorem Ipsum 1",
    "Lorem Ipsum 2",
    "Lorem Ipsum 3",
    "Lorem Ipsum 4",
    "Lorem Ipsum 5",
    "Lorem Ipsum 6",
    "Lorem Ipsum 7",
    "Lorem Ipsum 8",
    "Lorem Ipsum 9",
    "Lorem Ipsum 10",
    "Lorem Ipsum 11",
    "Lorem Ipsum 12",
    "Lorem Ipsum 13",
    "Lorem Ipsum 14",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainPageAppBar(),
      body: ListView(
        children: msgs.map((msg) => TodoCard(msg: msg)).toList(),
      ),
      floatingActionButton: AddTodoItemButton(),
    );
  }
}

class TodoCard extends StatelessWidget {
  TodoCard({super.key, required this.msg});

  final String msg;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: IconButton(
              onPressed: () => {},
              icon: Icon(
                Icons.check_box_outline_blank,
              ),
            ),
            title: Text(msg),
            trailing: IconButton(
                onPressed: () => {
                      // Remove todo
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

class AddToDoItemPage extends StatelessWidget {
  const AddToDoItemPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My to-do list",
          // style: TextStyle(color: whiteColor),
        ),
        backgroundColor: theme.colorScheme.primary,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'What are you going to do?'),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () => {
              // TODO add a new card and display
              Navigator.of(context).pop()
            },
            icon: const Icon(Icons.add),
            label: Text("ADD"),
          ),
        ],
      ),
    );
  }
}
