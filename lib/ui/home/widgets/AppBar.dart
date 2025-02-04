import 'package:flutter/material.dart';

class AppBar extends StatelessWidget {
  const AppBar({Key? key, required Color backgroundColor, required Text title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: const Text('SportBoard'),
    );
  }
}