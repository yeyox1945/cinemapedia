import 'package:cinemapedia/infrastructure/datasources/actor_moviedb_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/actor_repository_impl.dart';
import 'package:cinemapedia/presentation/blocs/actor/actor_bloc.dart';
import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/home/0',
  routes: [
    GoRoute(
      path: '/home/:page',
      name: HomeScreen.name,
      builder: (context, state) {
        final int pageIndex = int.parse(state.pathParameters['page'] ?? '0');

        return HomeScreen(
          pageIndex: pageIndex,
        );
      },
      routes: [
        GoRoute(
          path: 'movie/:id',
          name: MovieScreen.name,
          builder: (context, state) {
            final movieId = state.pathParameters['id'] ?? 'no-id';
            final String heroTag = state.extra.toString();

            return BlocProvider(
              create: (context) => ActorBloc(
                  actorRepository:
                      ActorRepositoryImpl(ActorMovieDbDatasource())),
              child: MovieScreen(
                movieId: movieId,
                heroPrefix: heroTag,
              ),
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: '/',
      redirect: (_, __) => '/home/0',
    ),
  ],
);
