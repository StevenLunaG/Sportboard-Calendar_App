import 'package:http/http.dart' as http;

class TestApiService {
  // Si estás usando el emulador de Android, usa 10.0.2.2 en lugar de localhost
  // Para dispositivos físicos, usa la IP de tu máquina
  static const String baseUrl = 'http://10.0.2.2:9000/api/calendar';

  Future<String> getHello() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/hola'));

      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('Failed to load hello message');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<String> getAbel() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/abel'));

      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('Failed to load abel message');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}