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
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: mainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class mainPage extends StatelessWidget {
  const mainPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainPageAppBar(),
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
    const whiteColor = Colors.white;
    return AppBar(
      title: Center(
        child: Text(
          "My to-do list",
          style: TextStyle(color: whiteColor),
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
            color: whiteColor),
      ],
      backgroundColor: theme.colorScheme.primary,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
