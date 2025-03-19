import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/todo_category.dart';
import 'auth_service.dart';

class CategoryService {
  final AuthService _authService = AuthService();

  Future<Map<String, String>> _getAuthHeader() async {
    final token = await _authService.getToken();
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<List<TodoCategory>> getAllCategories() async {
    try {
      final headers = await _getAuthHeader();
      final response = await http.get(
        Uri.parse(ApiConfig.categoriesUrl),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => TodoCategory.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  Future<TodoCategory> createCategory(TodoCategory category) async {
    try {
      final headers = await _getAuthHeader();
      final response = await http.post(
        Uri.parse(ApiConfig.categoriesUrl),
        headers: headers,
        body: jsonEncode(category.toJson()),
      );

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        return TodoCategory.fromJson(data['data']);
      } else {
        throw Exception('Failed to create category');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  Future<TodoCategory> getCategoryById(int id) async {
    try {
      final headers = await _getAuthHeader();
      final response = await http.get(
        Uri.parse('${ApiConfig.categoriesUrl}/$id'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return TodoCategory.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load category');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  Future<TodoCategory> updateCategory(int id, TodoCategory category) async {
    try {
      final headers = await _getAuthHeader();
      final response = await http.put(
        Uri.parse('${ApiConfig.categoriesUrl}/$id'),
        headers: headers,
        body: jsonEncode(category.toJson()),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return TodoCategory.fromJson(data['data']);
      } else {
        throw Exception('Failed to update category');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  Future<bool> deleteCategory(int id) async {
    try {
      final headers = await _getAuthHeader();
      final response = await http.delete(
        Uri.parse('${ApiConfig.categoriesUrl}/$id'),
        headers: headers,
      );

      return response.statusCode == 200;
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }
}
