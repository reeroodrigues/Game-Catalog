import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'router/router.dart';
import 'features/home/data/models/game_model.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(GameModelAdapter());
  Hive.registerAdapter(GenreAdapter());
  Hive.registerAdapter(PlatformEntryAdapter());
  Hive.registerAdapter(PlatformInfoAdapter());
  await Hive.openBox<GameModel>('favorites');

  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(child: GameCatalogApp()));
}

class GameCatalogApp extends ConsumerWidget {
  const GameCatalogApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'Catálogo de Jogos',
      theme: ThemeData.dark(useMaterial3: true),
      routerConfig: router,
    );
  }
}
