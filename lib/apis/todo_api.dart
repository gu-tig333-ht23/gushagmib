import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import '../models/todo_item.dart';

const String API_KEY = 'abb6cf01-0a78-4af3-a786-9ea8819073fb';
const String ENDPOINT = 'https://todoapp-api.apps.k8s.gu.se';

class TodoAPI {
  static Future<void> add(ToDoItem item) async {
    await http.post(
      headers: {"Content-Type": "application/json"},
      Uri.parse('$ENDPOINT/todos?key=$API_KEY'),
      body: jsonEncode(item.toJson()),
    );
  }

  static Future<void> remove(ToDoItem item) async {
    String id = item.id;
    await http.delete(
      headers: {"Content-Type": "application/json"},
      Uri.parse('$ENDPOINT/todos/$id?key=$API_KEY'),
      body: jsonEncode(item.toJson()),
    );
  }

  static Future<List<ToDoItem>> fetchTodoItems() async {
    http.Response response =
        await http.get(Uri.parse('$ENDPOINT/todos?key=$API_KEY'));

    List<dynamic> jsonContents = await jsonDecode(response.body);
    return jsonContents
        .map((jsonContents) => ToDoItem.fromJson(jsonContents))
        .toList();
  }
}
