import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/collection_state.dart';

// Widgets
import '../widgets/todoTile_widget.dart';

class ReorderableListWidget extends StatefulWidget {
  const ReorderableListWidget({
    super.key,
  });

  @override
  State<ReorderableListWidget> createState() => _ReorderableListWidgetState();
}

class _ReorderableListWidgetState extends State<ReorderableListWidget> {
  @override
  Widget build(BuildContext context) {
    var collectionState = context.watch<TaskCollectionState>();
    var tasks = collectionState.taskList;
    return ReorderableListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return Container(
          key: ValueKey(tasks[index]),
          color: Theme.of(context).cardColor,
          child: Column(
            // Set a dividing line on top if index is 0 else below.
            children: index == 0
                ? <Widget>[
                    Divider(
                      height: 1,
                    ),
                    TodoTileWidget(item: tasks[index]),
                    Divider(height: 0),
                  ]
                : <Widget>[
                    TodoTileWidget(item: tasks[index]),
                    Divider(height: 0),
                  ],
          ),
        );
      },
      onReorder: (oldIndex, newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final task = collectionState.taskList.removeAt(oldIndex);
          tasks.insert(newIndex, task);
        });
      },
    );
  }
}
