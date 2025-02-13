import 'package:first/ui/Arbitro/arbitraje_screen.dart';
import 'package:first/ui/Calendar/calendar_screen.dart';
import 'package:first/ui/Competition/competition_example_screen.dart';
import 'package:first/ui/Arbitro/arbitro_screen.dart';
import 'package:first/ui/Notifications/notifications_manager.dart';
import 'package:first/ui/Profile/profile_screen.dart';
import 'package:first/ui/Searcher/searcher.dart';
import 'package:first/ui/Settings/settings_menu.dart';
import 'package:first/ui/home/home_screen.dart';
import 'package:flutter/material.dart';

import '../Arbitro/arbitro_screen.dart';
import '../Management/manage_screen.dart';
import '../admin/admin_interface.dart';
import '../admin/teams_page.dart';

class HomeInterfaceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();

  // Contenido de Home
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  bool isAdmin = true;

  // Lista de pantallas como clases separadas
  static final List<Widget> _pages = <Widget>[
    MainHomeScreen(),
    SearcherScreen(),
    ArbitroScreen(),
    //ManagementScreen(),
    CalendarScreen(),
    //TeamsPage(),
    SettingsMenu(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          'SportBoard',
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          if (isAdmin)
            IconButton(
              icon: const Icon(Icons.privacy_tip),
              tooltip: 'Admin',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminInterface()),
                );
              },
            ),
          IconButton(
            icon: const Icon(Icons.notifications),
            tooltip: 'Notificaciones',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationsManagerScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle),
            tooltip: 'Perfil',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: _pages[_selectedIndex], // Muestra la pantalla seleccionada
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/2.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.account_circle,
                    size: 80,
                    color: Colors.white,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Nickname',
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'username@example.com',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ),
            ExpansionTile(
              title: Text('Competencias'),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: ListTile(
                    title: Text(
                      'Subitem',
                      style: TextStyle(color: Colors.grey[800]),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CompetitionExampleScreen()),
                      );
                    },
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Arbitro'),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: ListTile(
                    title: Text(
                      'Subitem',
                      style: TextStyle(color: Colors.grey[800]),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ArbitroScreen()),
                      );
                    },
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Calendario'),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: ListTile(
                    title: Text(
                      'Subitem',
                      style: TextStyle(color: Colors.grey[800]),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CalendarScreen()),
                      );
                    },
                  ),
                ),
              ],
            ),
            ListTile(
              title: ElevatedButton(
                onPressed: () {
                  // Handle add favorite button press
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star),
                    SizedBox(width: 8),
                    Text('Agregar favorito'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Buscar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.manage_search),
            label: 'Arbitraje',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Calendario',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configuracion',
          ),
        ],
        currentIndex: _selectedIndex, // Elemento seleccionado actualmente
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.black45,
        onTap: _onItemTapped, // Cambia la pantalla al tocar un ítem
      ),
    );
  }
}