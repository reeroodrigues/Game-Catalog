import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:game_catalog_app/features/auth/auth_provider.dart';
import 'package:game_catalog_app/features/auth/screens/login_screen.dart';
import 'package:game_catalog_app/features/details/screens/game_details_screen.dart';
import 'package:game_catalog_app/features/favorites/presentation/favorites_screen.dart';
import 'package:game_catalog_app/features/home/data/models/game_model.dart';
import 'package:game_catalog_app/features/home/presentation/home_screen.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final isLoggedIn = ref.watch(isLoggedInProvider);

  return GoRouter(
    initialLocation: isLoggedIn ? '/' : '/login',
    refreshListenable:
        GoRouterRefreshStream(ref.watch(authStateProvider.stream)),
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/favorites',
        name: 'favorites',
        builder: (context, state) => const FavoritesScreen(),
      ),
      GoRoute(
        path: '/game-details',
        builder: (context, state) {
          final game = state.extra as GameModel;
          return GameDetailsScreen(game: game);
        },
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
    ],
    redirect: (context, state) {
      final isLoggedIn = ref.read(isLoggedInProvider);
      final isLoggingIn = state.uri.toString() == '/login';

      if (!isLoggedIn && !isLoggingIn) {
        return '/login';
      }

      if (isLoggedIn && isLoggingIn) {
        return '/';
      }

      return null;
    },
  );
});

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.asBroadcastStream().listen((_) {
      notifyListeners();
    });
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
