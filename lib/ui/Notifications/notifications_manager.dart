import 'package:flutter/material.dart';

class NotificationsManagerScreen extends StatefulWidget {
  @override
  _NotificationsManagerScreenState createState() => _NotificationsManagerScreenState();
}

class _NotificationsManagerScreenState extends State<NotificationsManagerScreen> {
  final List<Map<String, String>> _notifications = [
    {
      'date': '2023-10-01',
      'title': 'Notification 1',
      'description': 'This is a short description of notification 1...'
    },
    {
      'date': '2023-10-02',
      'title': 'Notification 2',
      'description': 'This is a short description of notification 2...'
    },
  ];

  void _removeNotification(int index) {
    setState(() {
      _notifications.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications Manager'),
      ),
      body: ListView.builder(
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_notifications[index]['title']!),
            subtitle: Text('${_notifications[index]['date']} - ${_notifications[index]['description']}'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _removeNotification(index),
            ),
          );
        },
      ),
    );
  }
}