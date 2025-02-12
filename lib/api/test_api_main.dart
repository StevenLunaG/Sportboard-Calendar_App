import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Teams API Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Teams API Test Page'),
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

  // Usar el mismo puerto que en tu backend
  final String baseUrl = 'http://localhost:9000/api/teams';

  Future<void> _fetchEquipos() async {
    setState(() {
      _isLoading = true;
      _response = 'Cargando...';
    });

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/equipos'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

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

  Future<void> _createTeam() async {
    setState(() {
      _isLoading = true;
      _response = 'Creando equipo...';
    });

    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          'name': 'Nuevo Equipo',
          // Agrega otros campos según tu modelo Team
        }),
      );

      setState(() {
        _response = response.statusCode == 200
            ? 'Equipo creado: ${response.body}'
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
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _response,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _fetchEquipos,
              child: const Text('Obtener Equipos'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _isLoading ? null : _createTeam,
              child: const Text('Crear Equipo'),
            ),
          ],
        ),
      ),
    );
  }
}