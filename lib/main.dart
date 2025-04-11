import 'package:flutter/material.dart';
import 'views/home_page.dart';

void main() {
  runApp(GameCatalogApp());
}

class GameCatalogApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game Catalog',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Color(0xFF1A1A1A),
      ),
      home: HomePage(),
    );
  }
}
