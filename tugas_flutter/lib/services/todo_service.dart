import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/todo.dart';
import 'auth_service.dart';

class TodoService {
  final AuthService _authService = AuthService();

  Future<Map<String, String>> _getAuthHeader() async {
    final token = await _authService.getToken();
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<List<Todo>> getAllTodos() async {
    try {
      final headers = await _getAuthHeader();
      final response = await http.get(
        Uri.parse(ApiConfig.todosUrl),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Todo.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load todos');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  Future<Todo> createTodo(Todo todo) async {
    try {
      final headers = await _getAuthHeader();
      final response = await http.post(
        Uri.parse(ApiConfig.todosUrl),
        headers: headers,
        body: jsonEncode(todo.toJson()),
      );

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        return Todo.fromJson(data);
      } else {
        throw Exception('Failed to create todo');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  Future<Todo> updateTodo(int id, Todo todo) async {
    try {
      final headers = await _getAuthHeader();
      final response = await http.put(
        Uri.parse('${ApiConfig.todosUrl}/$id'),
        headers: headers,
        body: jsonEncode(todo.toJson()),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Todo.fromJson(data);
      } else {
        throw Exception('Failed to update todo');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  Future<bool> deleteTodo(int id) async {
    try {
      final headers = await _getAuthHeader();
      final response = await http.delete(
        Uri.parse('${ApiConfig.todosUrl}/$id'),
        headers: headers,
      );

      return response.statusCode == 200;
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  Future<List<Todo>> searchTodos(String keyword) async {
    try {
      final headers = await _getAuthHeader();
      final response = await http.get(
        Uri.parse('${ApiConfig.searchTodosUrl}/$keyword'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Todo.fromJson(json)).toList();
      } else {
        throw Exception('Failed to search todos');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  Future<List<Todo>> sortByPriority() async {
    try {
      final headers = await _getAuthHeader();
      final response = await http.get(
        Uri.parse(ApiConfig.sortTodosByPriorityUrl),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Todo.fromJson(json)).toList();
      } else {
        throw Exception('Failed to sort todos');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  Future<List<Todo>> checkDeadlines() async {
    try {
      final headers = await _getAuthHeader();
      final response = await http.get(
        Uri.parse(ApiConfig.checkDeadlinesUrl),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Todo.fromJson(json)).toList();
      } else {
        throw Exception('Failed to check deadlines');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }
}
