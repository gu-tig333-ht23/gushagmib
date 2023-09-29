import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/todo_item.dart';
import '../controllers/collection_state.dart';

// Stateful since TodoTile only needs to manage it's own state.
class TodoTileWidget extends StatefulWidget {
  const TodoTileWidget({super.key, required this.item});

  final TodoItem item;

  @override
  State<TodoTileWidget> createState() => _TodoTileWidgetState();
}

class _TodoTileWidgetState extends State<TodoTileWidget> {
  // Controller for listening to the textfield
  final textFieldController = TextEditingController();
  bool isEditable = false;

  // have to manually dispose of the controller when widget is disposed.
  @override
  void dispose() {
    textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final collectionState = context.watch<TaskCollectionState>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 5),
          leading: checkBoxButton(collectionState),
          title: isEditable
              ? editText(collectionState, context)
              : showText(context),
          trailing: Wrap(
            spacing: -10,
            children: <Widget>[
              updateTextButton(collectionState),
              deleteTaskButton(context, collectionState),
            ],
          ),
        ),
      ],
    );
  }

  IconButton updateTextButton(TaskCollectionState collectionState) {
    return IconButton(
      onPressed: () async {
        if (textFieldController.text.isNotEmpty) {
          widget.item.text = textFieldController.text;
          // Wait for update to API
          await collectionState.updateTodoItem(widget.item);
        }

        setState(() {
          if (isEditable) {
            isEditable = false;
          } else {
            isEditable = true;
          }
        });
      },
      icon: isEditable ? Icon(Icons.check_sharp) : Icon(Icons.edit_outlined),
    );
  }

  IconButton deleteTaskButton(
      BuildContext context, TaskCollectionState collectionState) {
    return IconButton(
      onPressed: () async {
        final messenger = ScaffoldMessenger.of(context);
        // User have clicked on delete button, remove from collection
        await collectionState.remove(widget.item);
        // Refetch since
        await collectionState.fetchTasks();

        final undoDeletionSnackBar = showSnackBar(collectionState);

        messenger.showSnackBar(undoDeletionSnackBar);
      },
      icon: Icon(
        Icons.close,
      ),
    );
  }

  TextField editText(
      TaskCollectionState collectionState, BuildContext context) {
    return TextField(
      controller: textFieldController,
      onSubmitted: (value) async {
        if (value.isNotEmpty) {
          widget.item.text = value;
          // Wait for update to API
          await collectionState.updateTodoItem(widget.item);
        }
        // Rebuild
        setState(
          () {
            isEditable = false;
          },
        );
      },
      // Bring up the keyboard
      autofocus: true,
      style: Theme.of(context).textTheme.titleMedium,
      decoration: InputDecoration(
          // Remove all the border around textfield
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none),
    );
  }

  IconButton checkBoxButton(TaskCollectionState collectionState) {
    return IconButton(
      onPressed: () {
        setState(
          () {
            // The box is tapped, update the variable isDone.
            widget.item.updateIsDone();
            // Tell the state that an item has been updated and
            collectionState.updateTodoItem(widget.item);
          },
        );
      },
      icon: Icon(widget.item.isDone
          ? Icons.check_box_outlined
          : Icons.check_box_outline_blank),
    );
  }

  Text showText(BuildContext context) {
    return Text(widget.item.text,
        // Make a line through the text if it's marked as complete
        style: Theme.of(context).listTileTheme.titleTextStyle!.copyWith(
              decoration: widget.item.isDone
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ));
  }

  SnackBar showSnackBar(TaskCollectionState collectionState) {
    var removedTask = collectionState.lastRemovedTask;
    return SnackBar(
      duration: const Duration(seconds: 2),
      content: Text("Deleted: ${removedTask!.text}"),
      action: SnackBarAction(
        label: 'Undo deletion',
        onPressed: () async {
          await collectionState.add(removedTask);
          await collectionState.fetchTasks();
        },
      ),
    );
  }
}
