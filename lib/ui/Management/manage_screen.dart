import 'package:flutter/material.dart';
import 'competencias_tab.dart';
import 'partidos_tab.dart';
import 'equipos_tab.dart';

class ManagementScreen extends StatefulWidget {
  @override
  _ManagementScreenState createState() => _ManagementScreenState();
}

class _ManagementScreenState extends State<ManagementScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 3, // Eliminar el espacio del título
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Competencias'),
            Tab(text: 'Partidos'),
            Tab(text: 'Equipos'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          CompetenciasTab(),
          PartidosTab(),
          EquiposTab(),
        ],
      ),
    );
  }
}
