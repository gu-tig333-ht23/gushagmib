import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'add_item_page.dart';
// Themes
import '../themes/light_purple_theme.dart';
// Models
import '../model/task_collection.dart';

import '../model/todo_item.dart';
import '../model/enums.dart';

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
    var taskCollection = context.watch<TaskCollectionState>();
    return Scaffold(
      appBar: MainPageAppBar(),
      body: ListView(
          // Spawn the cards for the todo view
          children: taskCollection.taskList
              .map((item) => TodoCard(item: item))
              .toList()),
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

      // backgroundColor: theme.colorScheme.primary,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class PopUpMenu extends StatefulWidget {
  const PopUpMenu({
    super.key,
  });

  @override
  State<PopUpMenu> createState() => _PopUpMenuState();
}

class _PopUpMenuState extends State<PopUpMenu> {
  MenuOption? selectedOption;

  // Options for sorting the todo lists.
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(Icons.more_vert),
      initialValue: selectedOption,
      onSelected: (var option) {
        setState(() {
          selectedOption = option;
        });
      },
      itemBuilder: (context) => <PopupMenuEntry>[
        PopupMenuItem(
          value: MenuOption.all,
          child: Text(describeEnum(MenuOption.all)),
        ),
        PopupMenuItem(
          value: MenuOption.done,
          child: Text(describeEnum(MenuOption.done)),
        ),
        PopupMenuItem(
          value: MenuOption.undone,
          child: Text(describeEnum(MenuOption.undone)),
        ),
      ],
    );
  }
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
