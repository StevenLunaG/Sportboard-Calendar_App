import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/match.dart';

class CalendarProvider with ChangeNotifier {
  final String baseUrl = 'http://localhost:9000/api/matches';
  Map<DateTime, List<Match>> _matches = {};

  Map<DateTime, List<Match>> get matches => _matches;

  Future<void> loadMatches() async {
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
        _matches = {};
        for (var matchJson in data) {
          Match match = Match.fromJson(matchJson);
          DateTime matchDate = DateTime(match.date!.year, match.date!.month, match.date!.day);
          if (_matches[matchDate] == null) {
            _matches[matchDate] = [];
          }
          _matches[matchDate]!.add(match);
        }
        notifyListeners();
      } else {
        throw Exception('Failed to load matches');
      }
    } catch (e) {
      print('Error loading matches: $e');
    }
  }

  List<Match> getMatchesByDate(DateTime date) {
    return _matches[DateTime(date.year, date.month, date.day)] ?? [];
  }

  bool hasMatches(DateTime date) {
    return _matches.containsKey(DateTime(date.year, date.month, date.day));
  }
}