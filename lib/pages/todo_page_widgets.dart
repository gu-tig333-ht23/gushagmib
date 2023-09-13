import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/collection_controller_state.dart';
import 'add_item_page.dart';
import '../models/todo_item.dart';
import '../models/enums.dart';
import 'package:flutter/foundation.dart';

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
          // We dont want to listen only update the operation
          Provider.of<TaskCollectionController>(context, listen: false)
              .setOperation(selectedOption!);
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
    final controller = context.watch<TaskCollectionController>();
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
                style: textStyleTheme.copyWith(
                  decoration: widget.item.isDone
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                )),
            trailing: IconButton(
              onPressed: () => {
                // User have clicked on delete button, remove from collection
                controller.remove(widget.item),
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
