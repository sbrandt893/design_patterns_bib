import 'package:design_patterns_bib/app/frontend/router/approuter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Design Patterns Bib',
      initialRoute: Routes.home.name,
      onGenerateRoute: Approuter.generateRoute,
      debugShowCheckedModeBanner: false,
      // theme for app in amber colors also for appbar and body background
      theme: ThemeData(
        primarySwatch: Colors.amber,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.amber,
        ),
        scaffoldBackgroundColor: Colors.amber[100],
      ),
    );
  }
}


// ulf was here