import 'package:flutter/material.dart';
import 'views/home_page.dart';

void main() {
  runApp(GameCatalogApp());
}

class GameCatalogApp extends StatelessWidget {
  const GameCatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game Catalog',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF121212),
        cardColor: Color(0xFF2A2A2A),
        primaryColor: Colors.deepPurple,
        textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.white70)),
      ),
      home: HomePage(),
    );
  }
}
