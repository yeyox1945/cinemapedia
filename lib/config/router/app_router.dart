import 'package:cinemapedia/ui/screens/screens.dart';
import 'package:flutter/material.dart' show NavigatorState, GlobalKey;
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorAKey = GlobalKey<NavigatorState>();
final _shellNavigatorBKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  initialLocation: '/home',
  navigatorKey: _rootNavigatorKey,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNavigation(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorAKey,
          routes: [
            GoRoute(
                path: '/home',
                name: HomeScreen.name,
                builder: (context, state) => const HomeScreen()),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorBKey,
          routes: [
            GoRoute(
              path: '/favorites',
              name: FavoritesScreen.name,
              builder: (context, state) => const FavoritesScreen(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
        path: '/movies/:id',
        name: MovieScreen.name,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final movieId = state.pathParameters['id'] ?? 'no-id';
          final String heroTag = state.extra.toString();

          return MovieScreen(
            movieId: movieId,
            heroPrefix: heroTag,
          );
        }),
  ],
);
