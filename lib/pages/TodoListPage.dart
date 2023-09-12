import 'package:flutter/material.dart';
import 'package:template/states/TaskCollectionState.dart';
//import 'package:template/blackTheme.dart';
import 'addItemPage.dart';
import '../themes/lightPurpleTheme.dart';
import '../TodoItem.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => TaskCollectionState(),
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
    return Scaffold(
      appBar: MainPageAppBar(),
      body: ListView(
        // Spawn the cards for the todo view
        children: context
            .read<TaskCollectionState>()
            .taskList
            .map((item) => TodoCard(item: ToDoItem("TEST")))
            .toList(),
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
      // backgroundColor: theme.colorScheme.primary,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class TodoCard extends StatefulWidget {
  const TodoCard({super.key, required this.item});

  final ToDoItem item;

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  @override
  Widget build(BuildContext context) {
    var textStyleTheme = Theme.of(context).textTheme.bodyMedium!;
    final collectionState = context.watch<TaskCollectionState>();
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: IconButton(
              onPressed: () => {
                setState(
                  () {
                    if (widget.item.isDone) {
                      // Set to false since user tapped box
                      widget.item.setIsDone(false);
                    } else {
                      widget.item.setIsDone(true);
                    }
                  },
                ),
              },
              icon: Icon(widget.item.isDone
                  ? Icons.check_box_outlined
                  : Icons.check_box_outline_blank),
            ),
            title: Text(widget.item.getText(),
                // Make a line through the text if it's marked as complete
                style: textStyleTheme.copyWith(
                  decoration: widget.item.isDone
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                )),
            trailing: IconButton(
              onPressed: () => {
                // User have clicked on delete button, remove from collection
                collectionState.removeTask(widget.item),
              },
              icon: Icon(Icons.close),
            ),
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
