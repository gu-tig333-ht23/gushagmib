import 'package:flutter/material.dart';

class AddToDoItemPage extends StatelessWidget {
  const AddToDoItemPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My to-do list",
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: TextField(
              decoration:
                  InputDecoration(hintText: 'What are you going to do?'),
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
