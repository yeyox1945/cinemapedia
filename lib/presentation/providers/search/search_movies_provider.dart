import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';

final searchQueryProvider = StateProvider((ref) => '');

final searchedMoviesProvider = StateNotifierProvider<SearchedMoviesNotifier, List<Movie>>((ref) {
  final movieRepository = ref.read(movieRepositoryProvider);

  return SearchedMoviesNotifier(searchMovies: movieRepository.searchMovies, ref: ref);
});

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchedMoviesNotifier extends StateNotifier<List<Movie>> {
  SearchedMoviesNotifier({required this.searchMovies, required this.ref}) : super([]);

  final SearchMoviesCallback searchMovies;
  final Ref ref;

  Future<List<Movie>> searchMoviesByQuery(String query) async {
    final List<Movie> movies = await searchMovies(query);
    ref.read(searchQueryProvider.notifier).state = query;

    state = movies;
    return movies;
  }
}
