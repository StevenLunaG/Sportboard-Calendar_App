import 'package:first/providers/calendar_provider.dart';
      import 'package:first/ui/test_api.dart';
      import 'package:flutter/material.dart';
      import 'package:provider/provider.dart';
      import 'providers/data_provider.dart';
      import 'ui/admin/teams_page.dart';
      import 'ui/home/home_interface.dart';

      void main() {
        runApp(
          MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => DataProvider()),
              ChangeNotifierProvider(create: (_) => CalendarProvider()),
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