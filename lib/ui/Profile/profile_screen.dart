import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil de Usuario'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Editar Perfil',
            onPressed: () {
              // Acción al presionar el botón de editar perfil
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/profile_picture.png'),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                'Hollow User',
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                'hollowuser@unl.edu.ec',
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Información Adicional',
            ),
            const SizedBox(height: 8),
            Text(
              'Aquí puedes agregar más información sobre el usuario, como una breve biografía, intereses, etc.',
            ),
          ],
        ),
      ),
    );
  }
}