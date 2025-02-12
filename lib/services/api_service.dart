import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  // GET request genérico
  Future<List<T>> getAll<T>(String endpoint, T Function(Map<String, dynamic>) fromJson) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => fromJson(json)).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // POST request genérico
  Future<T> create<T>(String endpoint, dynamic data, T Function(Map<String, dynamic>) fromJson) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        return fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to create data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // PUT request genérico
  Future<T> update<T>(String endpoint, int id, dynamic data, T Function(Map<String, dynamic>) fromJson) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl$endpoint/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        return fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to update data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // DELETE request genérico
  Future<void> delete(String endpoint, int id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl$endpoint/$id'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode != 204) {
        throw Exception('Failed to delete data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}