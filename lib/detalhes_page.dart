import 'package:flutter/material.dart';

class DetalhesPage extends StatelessWidget {
  final Map<String, String> jogo;

  const DetalhesPage({super.key, required this.jogo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(jogo['titulo']!)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                jogo['imagem']!,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              jogo['sinopse']!,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            const Spacer(),
            ElevatedButton.icon(
              icon: Icon(Icons.favorite_border),
              label: Text("Adicionar à lista de desejos"),
              onPressed: () {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("Adicionado à lista!")));
              },
            ),
          ],
        ),
      ),
    );
  }
}
