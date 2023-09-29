import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/collection_state.dart';
import '../models/todo_item.dart';

class AddToDoItemPage extends StatefulWidget {
  const AddToDoItemPage({
    super.key,
  });

  @override
  State<AddToDoItemPage> createState() => _AddToDoItemPageState();
}

class _AddToDoItemPageState extends State<AddToDoItemPage> {
  // Controller for listening to the textfield
  final textFieldController = TextEditingController();

  // have to manually dispose of the controller when widget is disposed.
  @override
  void dispose() {
    textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var collectionState = context.read<TaskCollectionState>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "TodoHub",
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: TextField(
              autofocus: true,
              onSubmitted: (value) async {
                await addTodoItem(collectionState, textFieldController);
              },
              style: Theme.of(context).textTheme.titleMedium,
              controller: textFieldController,
              decoration: InputDecoration(
                hintText: 'What are you going to do?',
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () async {
              await addTodoItem(collectionState, textFieldController);
            },
            icon: const Icon(Icons.add),
            label: Text("ADD"),
          ),
        ],
      ),
    );
  }

  Future<void> addTodoItem(TaskCollectionState collectionState,
      TextEditingController controller) async {
    await collectionState.add(TodoItem(controller.text));
    await collectionState.fetchTasks();

    // If not mounted, return.
    if (!context.mounted) {
      return;
    }
    Navigator.of(context).pop();
  }
}
