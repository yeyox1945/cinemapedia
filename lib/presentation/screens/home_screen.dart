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

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
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
                    BlocProvider(
                      create: (context) =>
                          MoviesBloc(repository: getIt<MoviesRepository>())
                            ..add(NowPlaying()),
                      child: BlocBuilder<MoviesBloc, MoviesState>(
                        builder: (context, state) {
                          return switch (state) {
                            Initial() => const CircularProgressIndicator(),
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
                                          .read<MoviesBloc>()
                                          .add(NowPlaying());
                                    },
                                  ),
                                ],
                              ),
                            _ => const SizedBox.shrink(),
                          };
                        },
                      ),
                    ),
                    BlocProvider(
                      create: (context) =>
                          MoviesBloc(repository: getIt<MoviesRepository>())
                            ..add(Popular()),
                      child: BlocBuilder<MoviesBloc, MoviesState>(
                        builder: (context, state) {
                          return switch (state) {
                            Initial() => const CircularProgressIndicator(),
                            Success(:final movies) => MovieHorizontalListview(
                                movies: movies,
                                title: 'Populares',
                                loadNextPage: () {
                                  context.read<MoviesBloc>().add(Popular());
                                },
                              ),
                            _ => const SizedBox.shrink(),
                          };
                        },
                      ),
                    ),
                    BlocProvider(
                      create: (context) =>
                          MoviesBloc(repository: getIt<MoviesRepository>())
                            ..add(Upcoming()),
                      child: BlocBuilder<MoviesBloc, MoviesState>(
                        builder: (context, state) {
                          return switch (state) {
                            Initial() => const CircularProgressIndicator(),
                            Success(:final movies) => MovieHorizontalListview(
                                movies: movies,
                                title: 'Proximamente',
                                loadNextPage: () {
                                  context.read<MoviesBloc>().add(Upcoming());
                                },
                              ),
                            _ => const SizedBox.shrink(),
                          };
                        },
                      ),
                    ),
                    BlocProvider(
                      create: (context) =>
                          MoviesBloc(repository: getIt<MoviesRepository>())
                            ..add(TopRated()),
                      child: BlocBuilder<MoviesBloc, MoviesState>(
                        builder: (context, state) {
                          return switch (state) {
                            Initial() => const CircularProgressIndicator(),
                            Success(:final movies) => MovieHorizontalListview(
                                movies: movies,
                                title: 'Mejor calificadas',
                                loadNextPage: () {
                                  context.read<MoviesBloc>().add(TopRated());
                                },
                              ),
                            _ => const SizedBox.shrink(),
                          };
                        },
                      ),
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
    );
  }

  @override
  bool get wantKeepAlive => true;
}
