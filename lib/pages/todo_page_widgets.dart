import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/collection_controller_state.dart';
import 'add_item_page.dart';
import '../models/todo_item.dart';
import '../models/enums.dart';
import 'package:flutter/foundation.dart';
import 'toggle_theme.dart';



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



// Stateful since PopUpMenu only needs to manage it's own state.
class PopUpMenu extends StatefulWidget {
  const PopUpMenu({
    super.key,
  });

  @override
  State<PopUpMenu> createState() => _PopUpMenuState();
}

class _PopUpMenuState extends State<PopUpMenu> {
  // Default is the option "all"
  MenuOption selectedOption = MenuOption.all;

  // Options for sorting the todo lists.
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(Icons.more_vert),
      initialValue: selectedOption,
      onSelected: (var option) {
        setState(() {
          selectedOption = option;
          // We dont want to listen only update the operation
          Provider.of<TaskCollectionController>(context, listen: false)
              .setOperation(selectedOption);
        });
      },
      itemBuilder: (context) =>
          MenuOption.values.map((option) => createMenuItem(option)).toList(),
    );
  }

  PopupMenuItem<dynamic> createMenuItem(MenuOption option) {
    return PopupMenuItem(
      value: option,
      child: Text(describeEnum(option)),
    );
  }
}

// Stateful since TodoTile only needs to manage it's own state.
class TodoTile extends StatefulWidget {
  const TodoTile({super.key, required this.item});

  final ToDoItem item;

  @override
  State<TodoTile> createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  @override
  Widget build(BuildContext context) {
    final controller = context.watch<TaskCollectionController>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 5),
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
                  // Send request to controller to notify that the list has changed
                  controller.updateItemList();
                },
              ),
            },
            icon: Icon(widget.item.isDone
                ? Icons.check_box_outlined
                : Icons.check_box_outline_blank),
          ),
          title: Text(widget.item.getText(),
              // Make a line through the text if it's marked as complete
              style: Theme.of(context).listTileTheme.titleTextStyle!.copyWith(
                    decoration: widget.item.isDone
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  )),
          trailing: IconButton(
            onPressed: ()  {
                            // User have clicked on delete button, remove from collection
              controller.remove(widget.item);

              String msg = "You deleted the task: ${controller.lastRemovedTask!.getText()}";
              final undoDeletionSnackBar =  SnackBar(content:  Text(msg),
              action: SnackBarAction(
                label: 'Undo deletion', 
                onPressed: () => {controller.add(controller.lastRemovedTask!),},),);
                ScaffoldMessenger.of(context).showSnackBar(undoDeletionSnackBar);


            },
            icon: Icon(
              Icons.close,
            ),
          ),
        ),
      ],
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
