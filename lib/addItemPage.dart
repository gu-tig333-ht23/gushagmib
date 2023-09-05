import 'package:flutter/material.dart';

class AddToDoItemPage extends StatelessWidget {
  const AddToDoItemPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My to-do list",
          // style: TextStyle(color: whiteColor),
        ),
        backgroundColor: theme.colorScheme.primary,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'What are you going to do?'),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () => {Navigator.of(context).pop()},
            icon: const Icon(Icons.add),
            label: Text("ADD"),
          ),
        ],
      ),
    );
  }
}
