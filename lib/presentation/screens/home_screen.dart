import 'package:cinemapedia/domain/repositories/movies_repository.dart';
import 'package:cinemapedia/main.dart' show getIt;
import 'package:cinemapedia/presentation/blocs/movies/bloc/movies_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const name = 'home';

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NowPlayingMoviesBloc(
            repository: getIt<MoviesRepository>(),
          )..add(NowPlaying()),
        ),
        BlocProvider(
          create: (context) => PopularMoviesBloc(
            repository: getIt<MoviesRepository>(),
          )..add(Popular()),
        ),
        BlocProvider(
          create: (context) => UpcomingMoviesBloc(
            repository: getIt<MoviesRepository>(),
          )..add(Upcoming()),
        ),
        BlocProvider(
          create: (context) => TopRatedMoviesBloc(
            repository: getIt<MoviesRepository>(),
          )..add(TopRated()),
        ),
      ],
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: RefreshIndicator(
              onRefresh: () async {
                final nowPlayingBloc = context.read<NowPlayingMoviesBloc>();
                final popularBloc = context.read<PopularMoviesBloc>();
                final upcomingBloc = context.read<UpcomingMoviesBloc>();
                final topRatedBloc = context.read<TopRatedMoviesBloc>();

                nowPlayingBloc.add(NowPlaying(refresh: true));
                popularBloc.add(Popular(refresh: true));
                upcomingBloc.add(Upcoming(refresh: true));
                topRatedBloc.add(TopRated(refresh: true));

                await Future.wait([
                  nowPlayingBloc.stream.firstWhere(
                    (state) => state is! Loading,
                  ),
                  popularBloc.stream.firstWhere(
                    (state) => state is! Loading,
                  ),
                  upcomingBloc.stream.firstWhere(
                    (state) => state is! Loading,
                  ),
                  topRatedBloc.stream.firstWhere(
                    (state) => state is! Loading,
                  ),
                ]);
              },
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                slivers: [
                  const SliverAppBar(
                    floating: true,
                    flexibleSpace: FlexibleSpaceBar(
                      titlePadding: EdgeInsets.all(0),
                      title: CustomAppbar(),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Column(
                          children: [
                            BlocBuilder<NowPlayingMoviesBloc, MoviesState>(
                              builder: (context, state) {
                                return switch (state) {
                                  Initial() =>
                                    const CircularProgressIndicator(),
                                  Success(:final movies) => Column(
                                      children: [
                                        MoviesSlideshow(
                                          movies: movies.take(6).toList(),
                                        ),
                                        MovieHorizontalListview(
                                          movies: movies.sublist(6),
                                          title: 'En cines',
                                          subTitle: 'Lunes 20',
                                          loadNextPage: () {
                                            context
                                                .read<NowPlayingMoviesBloc>()
                                                .add(NowPlaying());
                                          },
                                        ),
                                      ],
                                    ),
                                  _ => const SizedBox.shrink(),
                                };
                              },
                            ),
                            BlocBuilder<PopularMoviesBloc, MoviesState>(
                              builder: (context, state) {
                                return switch (state) {
                                  Initial() =>
                                    const CircularProgressIndicator(),
                                  Success(:final movies) =>
                                    MovieHorizontalListview(
                                      movies: movies,
                                      title: 'Populares',
                                      loadNextPage: () {
                                        context
                                            .read<PopularMoviesBloc>()
                                            .add(Popular());
                                      },
                                    ),
                                  _ => const SizedBox.shrink(),
                                };
                              },
                            ),
                            BlocBuilder<UpcomingMoviesBloc, MoviesState>(
                              builder: (context, state) {
                                return switch (state) {
                                  Initial() =>
                                    const CircularProgressIndicator(),
                                  Success(:final movies) =>
                                    MovieHorizontalListview(
                                      movies: movies,
                                      title: 'Proximamente',
                                      loadNextPage: () {
                                        context
                                            .read<UpcomingMoviesBloc>()
                                            .add(Upcoming());
                                      },
                                    ),
                                  _ => const SizedBox.shrink(),
                                };
                              },
                            ),
                            BlocBuilder<TopRatedMoviesBloc, MoviesState>(
                              builder: (context, state) {
                                return switch (state) {
                                  Initial() =>
                                    const CircularProgressIndicator(),
                                  Success(:final movies) =>
                                    MovieHorizontalListview(
                                      movies: movies,
                                      title: 'Mejor calificadas',
                                      loadNextPage: () {
                                        context
                                            .read<TopRatedMoviesBloc>()
                                            .add(TopRated());
                                      },
                                    ),
                                  _ => const SizedBox.shrink(),
                                };
                              },
                            ),
                            const SizedBox(height: 10),
                          ],
                        );
                      },
                      childCount: 1,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
