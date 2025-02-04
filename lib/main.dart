import 'package:first/providers/calendar_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/data_provider.dart';
import 'ui/home/home_interface.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DataProvider()),
  ChangeNotifierProxyProvider<DataProvider, CalendarProvider>(
  create: (context) => CalendarProvider(context.read<DataProvider>()),
  update: (context, dataProvider, previousCalendarProvider) =>
  CalendarProvider(dataProvider),
      ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SportBoard',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeInterfaceScreen(),
    );
  }
}
