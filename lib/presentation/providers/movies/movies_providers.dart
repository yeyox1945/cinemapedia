import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/models/paginated_state.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'movies_providers.g.dart';

enum MovieType { nowPlaying, popular, topRated, upcoming }

@riverpod
class MoviesNotifier extends _$MoviesNotifier {
  @override
  Future<PaginatedState<Movie>> build(MovieType movieType) async {
    _movieType = movieType;
    final results = await _fetch(page: 1);
    return PaginatedState(
        items: results, page: 1, hasNextPage: results.isNotEmpty);
  }

  late MovieType? _movieType;

  Future<void> fetchMoreMovies() async {
    assert(_movieType != null, 'Movie type must be provided');

    // Prevent fetching if already loading or if no more data is available
    if (state.isLoading || state.value?.hasNextPage == false) return;

    final currentState = state.value!;
    final nextPage = currentState.page + 1;

    // Set state to loading while retaining existing data
    state = const AsyncLoading<PaginatedState<Movie>>().copyWithPrevious(state);

    state = await AsyncValue.guard(() async {
      final newItems = await _fetch(page: nextPage);

      return PaginatedState(
        items: [...currentState.items, ...newItems],
        page: nextPage,
        hasNextPage: newItems.isNotEmpty,
      );
    });
  }

  Future<List<Movie>> _fetch({required int page}) {
    final moviesRepository = ref.read(movieRepositoryProvider);

    return switch (_movieType) {
      MovieType.nowPlaying => moviesRepository.getNowPlaying,
      MovieType.popular => moviesRepository.getPopular,
      MovieType.topRated => moviesRepository.getTopRated,
      MovieType.upcoming => moviesRepository.getUpcoming,
      null => throw UnimplementedError(),
    }(page: page);
  }
}
