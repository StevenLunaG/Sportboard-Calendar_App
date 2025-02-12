// main.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'API Test Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _response = 'No hay respuesta aún';
  bool _isLoading = false;

  // Como estás usando el emulador en Edge, usa localhost
  final String baseUrl = 'http://localhost:9000/api/calendar';

  Future<void> _fetchHola() async {
    setState(() {
      _isLoading = true;
      _response = 'Cargando...';
    });

    try {
      final response = await http.get(Uri.parse('$baseUrl/hola'));

      setState(() {
        _response = response.statusCode == 200
            ? response.body
            : 'Error: ${response.statusCode}';
      });
    } catch (e) {
      setState(() {
        _response = 'Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchAbel() async {
    setState(() {
      _isLoading = true;
      _response = 'Cargando...';
    });

    try {
      final response = await http.get(Uri.parse('$baseUrl/abel'));

      setState(() {
        _response = response.statusCode == 200
            ? response.body
            : 'Error: ${response.statusCode}';
      });
    } catch (e) {
      setState(() {
        _response = 'Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_isLoading)
              const CircularProgressIndicator()
            else
              Text(
                _response,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _fetchHola,
              child: const Text('Probar /hola'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _isLoading ? null : _fetchAbel,
              child: const Text('Probar /abel'),
            ),
          ],
        ),
      ),
    );
  }
}