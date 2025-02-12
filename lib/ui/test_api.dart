import 'package:flutter/material.dart';

import '../api/test_api_service.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final TestApiService _apiService = TestApiService();
  String _message = '';
  String _abelMessage = '';

  Future<void> _fetchHello() async {
    try {
      final response = await _apiService.getHello();
      setState(() {
        _message = response;
      });
    } catch (e) {
      setState(() {
        _message = 'Error: $e';
      });
    }
  }

  Future<void> _fetchAbel() async {
    try {
      final response = await _apiService.getAbel();
      setState(() {
        _abelMessage = response;
      });
    } catch (e) {
      setState(() {
        _abelMessage = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Test'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _fetchHello,
              child: Text('Get Hello Message'),
            ),
            SizedBox(height: 20),
            Text(_message),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: _fetchAbel,
              child: Text('Get Abel Message'),
            ),
            SizedBox(height: 20),
            Text(_abelMessage),
          ],
        ),
      ),
    );
  }
}