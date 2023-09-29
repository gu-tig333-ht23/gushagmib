import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/todo_item.dart';

class TodoAPI {
  static const String _API_KEY = 'abb6cf01-0a78-4af3-a786-9ea8819073fb';
  static const String _ENDPOINT = 'https://todoapp-api.apps.k8s.gu.se';
  static Future<void> add(TodoItem item) async {
    await http.post(
      headers: {"Content-Type": "application/json"},
      Uri.parse('$_ENDPOINT/todos?key=$_API_KEY'),
      body: jsonEncode(item.toJson()),
    );
  }

  static Future<void> remove(TodoItem item) async {
    String id = item.id;
    await http.delete(
      headers: {"Content-Type": "application/json"},
      Uri.parse('$_ENDPOINT/todos/$id?key=$_API_KEY'),
      body: jsonEncode(item.toJson()),
    );
  }

  static Future<void> update(TodoItem item) async {
    String id = item.id;
    await http.put(
      headers: {"Content-Type": "application/json"},
      Uri.parse('$_ENDPOINT/todos/$id?key=$_API_KEY'),
      body: jsonEncode(item.toJson()),
    );
  }

  static Future<List<TodoItem>> fetchTodoItems() async {
    http.Response response =
        await http.get(Uri.parse('$_ENDPOINT/todos?key=$_API_KEY'));

    List<dynamic> jsonContents = await jsonDecode(response.body);
    return jsonContents
        .map((jsonContents) => TodoItem.fromJson(jsonContents))
        .toList();
  }
}
