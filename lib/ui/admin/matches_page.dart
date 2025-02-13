import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../models/enums/status.dart';
import '../../models/match.dart';
import '../../models/team.dart';

class MatchesPage extends StatefulWidget {
  @override
  _MatchesPageState createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage> {
  final String baseUrl = 'http://localhost:9000/api/matches';
  final String teamsUrl = 'http://localhost:9000/api/teams/equipos';
  List<Match> _matches = [];
  List<Team> _teams = [];
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadMatches();
    _loadTeams();
  }


  Future<void> _loadTeams() async {
    try {
      final response = await http.get(
        Uri.parse(teamsUrl), // Usando la URL corregida
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          _teams = data.map((json) => Team.fromJson(json)).toList();
        });
      } else {
        print('Error loading teams: Status ${response.statusCode}');
      }
    } catch (e) {
      print('Error loading teams: $e');
    }
  }

  Future<void> _loadMatches() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          _matches = data.map((json) => Match.fromJson(json)).toList();
          _isLoading = false;
        });
      } else {
        setState(() {
          _error = 'Error: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Error: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _createMatch(Match match) async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      // Crear el objeto JSON manualmente para asegurar el formato correcto
      final Map<String, dynamic> matchJson = {
        'date': DateFormat('yyyy-MM-dd').format(match.date!),
        'startTime': '${match.startTime!.hour.toString().padLeft(2, '0')}:${match.startTime!.minute.toString().padLeft(2, '0')}:00',
        'homeTeam': {
          'id': match.homeTeam!.id,
          'name': match.homeTeam!.name,
        },
        'guestTeam': {
          'id': match.guestTeam!.id,
          'name': match.guestTeam!.name,
        },
        'duration': null,
        'finishTime': null,
        'scoreboard': null,
        'count': null,
        'status': 'PENDING'
      };

      print('Sending match data: ${json.encode(matchJson)}'); // Para debugging

      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(matchJson),
      );

      if (response.statusCode == 200) {
        _loadMatches();
      } else {
        print('Server response: ${response.body}'); // Para debugging
        setState(() {
          _error = 'Error ${response.statusCode}: ${response.body}';
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error creating match: $e'); // Para debugging
      setState(() {
        _error = 'Error: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _deleteMatch(int id) async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 204) {
        _loadMatches();
      } else {
        setState(() {
          _error = 'Error: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Error: $e';
        _isLoading = false;
      });
    }
  }

Future<void> _showCreateMatchDialog(BuildContext context) async {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  Team? selectedHomeTeam;
  Team? selectedGuestTeam;

  return showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        title: Text('Crear Partido'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Fecha: ${DateFormat('yyyy-MM-dd').format(selectedDate)}'),
                trailing: Icon(Icons.calendar_today),
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null && picked != selectedDate) {
                    setState(() => selectedDate = picked);
                  }
                },
              ),
              ListTile(
                title: Text('Hora: ${selectedTime.format(context)}'),
                trailing: Icon(Icons.access_time),
                onTap: () async {
                  final TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: selectedTime,
                  );
                  if (picked != null) {
                    setState(() => selectedTime = picked);
                  }
                },
              ),
              DropdownButtonFormField<Team>(
                decoration: InputDecoration(labelText: 'Equipo Local'),
                value: selectedHomeTeam,
                items: _teams.where((team) => team != selectedGuestTeam).map((team) {
                  return DropdownMenuItem(
                    value: team,
                    child: Text(team.name ?? 'Sin nombre'),
                  );
                }).toList(),
                onChanged: (Team? value) {
                  setState(() => selectedHomeTeam = value);
                },
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<Team>(
                decoration: InputDecoration(labelText: 'Equipo Visitante'),
                value: selectedGuestTeam,
                items: _teams.where((team) => team != selectedHomeTeam).map((team) {
                  return DropdownMenuItem(
                    value: team,
                    child: Text(team.name ?? 'Sin nombre'),
                  );
                }).toList(),
                onChanged: (Team? value) {
                  setState(() => selectedGuestTeam = value);
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              if (selectedHomeTeam == null || selectedGuestTeam == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Por favor seleccione ambos equipos')),
                );
                return;
              }

              final newMatch = Match(
                date: selectedDate,
                startTime: selectedTime,
                homeTeam: selectedHomeTeam,
                guestTeam: selectedGuestTeam,
                duration: null,
                finishTime: null,
                scoreboard: null,
                count: null,
                status: Status.PENDING,
              );
              _createMatch(newMatch);
              Navigator.pop(context);
            },
            child: Text('Crear'),
          ),
        ],
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _error != null
          ? Center(child: Text(_error!))
          : ListView.builder(
        itemCount: _matches.length,
        itemBuilder: (context, index) {
          final match = _matches[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(
                  '${match.homeTeam?.name ?? 'Local'} vs ${match.guestTeam?.name ?? 'Visitante'}'
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Fecha: ${match.formattedDate}'),
                  Text('Hora: ${match.formattedStartTime}'),
                  Text('Estado: ${match.status.toString().split('.').last}'),
                ],
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => _deleteMatch(match.id!),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateMatchDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
//TOY RE BIEN WACHO