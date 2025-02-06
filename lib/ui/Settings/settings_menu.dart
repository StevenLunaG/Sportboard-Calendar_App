import 'package:flutter/material.dart';

class SettingsMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.account_circle, size: 50),
            title: Text('Nickname', style: TextStyle(fontSize: 18)),
            subtitle: Text('username@example.com', style: TextStyle(fontSize: 14)),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('General Settings'),
            onTap: () {
              // Handle tap
            },
          ),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text('Privacy Settings'),
            onTap: () {
              // Handle tap
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notificaciones'),
            onTap: () {
              // Handle tap
            },
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Acerca de'),
            onTap: () {
              // Handle tap
            },
          ),
        ],
      ),
    );
  }
}