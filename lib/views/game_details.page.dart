import 'package:flutter/material.dart';
import '../models/game.dart';

class GameDetailsPage extends StatefulWidget {
  final Game game;

  const GameDetailsPage({required this.game});

  @override
  State<GameDetailsPage> createState() => _GameDetailsPageState();
}

class _GameDetailsPageState extends State<GameDetailsPage> {
  String status = "Deseja jogar";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.game.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(widget.game.imageUrl),
            ),
            SizedBox(height: 16),
            Text(
              widget.game.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(widget.game.console),
            SizedBox(height: 12),
            Text(widget.game.description),
            SizedBox(height: 24),
            Text("Status:", style: TextStyle(fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: status,
              onChanged: (value) {
                setState(() {
                  status = value!;
                });
              },
              items:
                  ["Jogando", "Joguei", "Deseja jogar"]
                      .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                      .toList(),
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Adicionado à lista de desejos!")),
                );
              },
              icon: Icon(Icons.favorite_border),
              label: Text("Adicionar à lista de desejos"),
            ),
          ],
        ),
      ),
    );
  }
}
