import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/providers.dart';
import '../widgets/widgets.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  static const name = 'home';

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    final slideShowMovies = ref.watch(moviesSlideshowProvider);
    final nowPlayingMovies =
        ref.watch(moviesNotifierProvider(MovieType.nowPlaying));
    final popularMovies = ref.watch(moviesNotifierProvider(MovieType.popular));
    final topRatedMovies =
        ref.watch(moviesNotifierProvider(MovieType.topRated));
    final upcomingMovies =
        ref.watch(moviesNotifierProvider(MovieType.upcoming));

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
                    slideShowMovies.when(
                        data: (movies) => MoviesSlideshow(movies: movies),
                        loading: () => const CircularProgressIndicator(),
                        error: (e, s) => const SizedBox()),
                    nowPlayingMovies.when(
                        data: (nowPlayingMovies) => MovieHorizontalListview(
                              movies: nowPlayingMovies.items,
                              title: 'En cines',
                              subTitle: 'Lunes 20',
                              loadNextPage: () {
                                ref
                                    .read(moviesNotifierProvider(
                                            MovieType.nowPlaying)
                                        .notifier)
                                    .fetchMoreMovies();
                              },
                            ),
                        error: (e, s) => const SizedBox(),
                        loading: () => const CircularProgressIndicator()),
                    popularMovies.when(
                        data: (popularMovies) => MovieHorizontalListview(
                              movies: popularMovies.items,
                              title: 'Populares',
                              loadNextPage: () {
                                ref
                                    .read(moviesNotifierProvider(
                                            MovieType.popular)
                                        .notifier)
                                    .fetchMoreMovies();
                              },
                            ),
                        error: (e, s) => const SizedBox(),
                        loading: () => const CircularProgressIndicator()),
                    upcomingMovies.when(
                        data: (upcomingMovies) => MovieHorizontalListview(
                              movies: upcomingMovies.items,
                              title: 'Proximamente',
                              loadNextPage: () {
                                ref
                                    .read(moviesNotifierProvider(
                                            MovieType.upcoming)
                                        .notifier)
                                    .fetchMoreMovies();
                              },
                            ),
                        error: (e, s) => const SizedBox(),
                        loading: () => const CircularProgressIndicator()),
                    topRatedMovies.when(
                        data: (topRatedMovies) => MovieHorizontalListview(
                              movies: topRatedMovies.items,
                              title: 'Mejor calificadas',
                              subTitle: 'Desde siempre',
                              loadNextPage: () {
                                ref
                                    .read(moviesNotifierProvider(
                                            MovieType.topRated)
                                        .notifier)
                                    .fetchMoreMovies();
                              },
                            ),
                        error: (e, s) => const SizedBox(),
                        loading: () => const CircularProgressIndicator()),
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
