import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/todo_item.dart';
import '../controllers/collection_state.dart';

// Models
// Stateful since TodoTile only needs to manage it's own state.
class TodoTileWidget extends StatefulWidget {
  const TodoTileWidget({super.key, required this.item});

  final TodoItem item;

  @override
  State<TodoTileWidget> createState() => _TodoTileWidgetState();
}

class _TodoTileWidgetState extends State<TodoTileWidget> {
  @override
  Widget build(BuildContext context) {
    final collectionState = context.watch<TaskCollectionState>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 5),
          leading: IconButton(
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
          ),
          title: Text(widget.item.text,
              // Make a line through the text if it's marked as complete
              style: Theme.of(context).listTileTheme.titleTextStyle!.copyWith(
                    decoration: widget.item.isDone
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  )),
          trailing: IconButton(
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
          ),
        ),
      ],
    );
  }

  SnackBar showSnackBar(TaskCollectionState collectionState) {
    var removedTask = collectionState.lastRemovedTask;
    return SnackBar(
      duration: const Duration(seconds: 2),
      content: Text("You deleted the task: ${removedTask!.text}"),
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
