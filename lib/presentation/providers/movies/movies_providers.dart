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
        items: results, page: 2, hasNextPage: true, isLoading: false);
  }

  late MovieType? _movieType;

  Future<void> fetchMoreMovies() async {
    assert(_movieType != null, 'Movie type must be provided');

    final currentState = state.value;

    // Avoid duplicate requests
    if (currentState == null ||
        currentState.isLoading ||
        !currentState.hasNextPage) {
      return;
    }

    state = AsyncData(
      currentState.copyWith(isLoading: true),
    );

    try {
      final nextPage = currentState.page;
      final results = await _fetch(page: nextPage + 1);

      state = AsyncData(
        PaginatedState(
            items: [...currentState.items, ...results],
            page: nextPage + 1,
            hasNextPage: results.isNotEmpty,
            isLoading: false),
      );
    } catch (e) {
      state = AsyncData(
        currentState.copyWith(
          isLoading: false,
        ),
      );
    }
  }

  Future<List<Movie>> _fetch({required int page}) async {
    final moviesRepository = ref.read(movieRepositoryProvider);

    return await switch (_movieType) {
      MovieType.nowPlaying => moviesRepository.getNowPlaying,
      MovieType.popular => moviesRepository.getPopular,
      MovieType.topRated => moviesRepository.getTopRated,
      MovieType.upcoming => moviesRepository.getUpcoming,
      null => throw UnimplementedError(),
    }(page: page);
  }
}
