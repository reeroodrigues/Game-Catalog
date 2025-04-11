import 'package:flutter/material.dart';
import '../models/game.dart';
import 'package:catalogo_de_jogos/views/game_gallery.dart';

class HomePage extends StatelessWidget {
  final List<Game> games = [
    Game(
      id: '1',
      title: 'The Legend of Zelda: Breath of the Wild',
      console: 'Nintendo Switch',
      description: 'Explore um mundo vasto e aberto com total liberdade.',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/en/thumb/c/cc/The_Legend_of_Zelda_Breath_of_the_Wild.jpg/220px-The_Legend_of_Zelda_Breath_of_the_Wild.jpg',
    ),
    Game(
      id: '2',
      title: 'God of War',
      console: 'PS4',
      description: 'Kratos embarca em uma jornada épica com seu filho Atreus.',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/en/thumb/a/a7/God_of_War_4_cover.jpg/220px-God_of_War_4_cover.jpg',
    ),
    Game(
      id: '3',
      title: 'The Last of Us',
      console: 'PS3 / PS4',
      description: 'Uma jornada emocional em um mundo pós-apocalíptico.',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/en/thumb/c/c2/The_Last_of_Us_cover.jpg/220px-The_Last_of_Us_cover.jpg',
    ),
    Game(
      id: '4',
      title: 'EA FC 24',
      console: 'Multiplataforma',
      description: 'O novo futebol da EA Sports com motor Frostbite.',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/en/thumb/b/b4/EA_Sports_FC_24_cover.jpg/220px-EA_Sports_FC_24_cover.jpg',
    ),
    Game(
      id: '5',
      title: 'Red Dead Redemption II',
      console: 'PS4 / Xbox / PC',
      description: 'A vida de um fora-da-lei no Velho Oeste.',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/en/thumb/4/44/Red_Dead_Redemption_II.jpg/220px-Red_Dead_Redemption_II.jpg',
    ),
    Game(
      id: '6',
      title: 'Horizon Zero Dawn',
      console: 'PS4',
      description: 'Caçadora enfrenta máquinas em um mundo selvagem.',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/en/thumb/0/0d/Horizon_Zero_Dawn.jpg/220px-Horizon_Zero_Dawn.jpg',
    ),
    Game(
      id: '7',
      title: 'Cyberpunk 2077',
      console: 'PS4 / Xbox / PC',
      description: 'Explore Night City como um mercenário cibernético.',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/en/thumb/9/9f/Cyberpunk_2077_box_art.jpg/220px-Cyberpunk_2077_box_art.jpg',
    ),
    Game(
      id: '8',
      title: 'Minecraft',
      console: 'Multiplataforma',
      description: 'Construa, explore e sobreviva em um mundo de blocos.',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/en/thumb/5/51/Minecraft_cover.png/220px-Minecraft_cover.png',
    ),
  ];
  // Adicione mais jogos aqui

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Catálogo de Jogos')),
      body: GameGallery(games: games),
    );
  }
}
