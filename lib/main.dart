import 'package:flutter/material.dart';

void main() {
  runApp(const TODOApp());
}

class TODOApp extends StatelessWidget {
  const TODOApp({super.key});

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
  const MainPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainPageAppBar(),
      floatingActionButton: AddTODOItemButton(),
    );
  }
}

class AddTODOItemButton extends StatelessWidget {
  const AddTODOItemButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const AddToDoItem()),
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

class AddToDoItem extends StatelessWidget {
  const AddToDoItem({
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
              // TODO add a new card
            },
            icon: const Icon(Icons.add),
            label: Text("ADD"),
          ),
        ],
      ),
    );
  }
}
