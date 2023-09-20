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
              style: Theme.of(context).textTheme.titleMedium,
              controller: textFieldController,
              decoration: InputDecoration(
                hintText: 'What are you going to do?',
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () async {
              // Add the text to our taskCollection
              ToDoItem newTask = ToDoItem(textFieldController.text);
              String title = newTask.getText;
              print("Title is: $title");
              context.read<TaskCollectionState>().add(newTask);

              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.add),
            label: Text("ADD"),
          ),
        ],
      ),
    );
  }
}
