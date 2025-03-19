import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/label.dart';
import 'auth_service.dart';

class LabelService {
  final AuthService _authService = AuthService();

  Future<Map<String, String>> _getAuthHeader() async {
    final token = await _authService.getToken();
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<List<Label>> getAllLabels() async {
    try {
      final headers = await _getAuthHeader();
      final response = await http.get(
        Uri.parse(ApiConfig.labelsUrl),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Label.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load labels');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  Future<Label> createLabel(Label label) async {
    try {
      final headers = await _getAuthHeader();
      final response = await http.post(
        Uri.parse(ApiConfig.labelsUrl),
        headers: headers,
        body: jsonEncode(label.toJson()),
      );

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        return Label.fromJson(data['data']);
      } else {
        throw Exception('Failed to create label');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  Future<Label> getLabelById(int id) async {
    try {
      final headers = await _getAuthHeader();
      final response = await http.get(
        Uri.parse('${ApiConfig.labelsUrl}/$id'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return Label.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load label');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  Future<Label> updateLabel(int id, Label label) async {
    try {
      final headers = await _getAuthHeader();
      final response = await http.put(
        Uri.parse('${ApiConfig.labelsUrl}/$id'),
        headers: headers,
        body: jsonEncode(label.toJson()),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Label.fromJson(data['data']);
      } else {
        throw Exception('Failed to update label');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  Future<bool> deleteLabel(int id) async {
    try {
      final headers = await _getAuthHeader();
      final response = await http.delete(
        Uri.parse('${ApiConfig.labelsUrl}/$id'),
        headers: headers,
      );

      return response.statusCode == 200;
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }
}
