import 'package:bloc_concurrency/bloc_concurrency.dart' show droppable;
import 'package:cinemapedia/domain/entities/movie.dart' show Movie;
import 'package:cinemapedia/domain/repositories/movies_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show debugPrint;
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'movies_event.dart';
part 'movies_state.dart';

enum Endpoint {
  nowPlaying,
  popular,
  upcoming,
  topRated,
}

class MoviesBloc extends HydratedBloc<MoviesEvent, MoviesState> {
  MoviesBloc({required this.key, required this.repository}) : super(Initial()) {
    on<NowPlaying>(_onNowPlaying, transformer: droppable());
    on<Popular>(_onPopular, transformer: droppable());
    on<Upcoming>(_onUpcoming, transformer: droppable());
    on<TopRated>(_onTopRated, transformer: droppable());
  }

  final String key;
  final MoviesRepository repository;

  @override
  String get id => key;

  Future<void> _onNowPlaying(
      NowPlaying event, Emitter<MoviesState> emit) async {
    await _fetchMovies(Endpoint.nowPlaying, event.refresh, emit);
  }

  Future<void> _onPopular(Popular event, Emitter<MoviesState> emit) async {
    await _fetchMovies(Endpoint.popular, event.refresh, emit);
  }

  Future<void> _onUpcoming(Upcoming event, Emitter<MoviesState> emit) async {
    await _fetchMovies(Endpoint.upcoming, event.refresh, emit);
  }

  Future<void> _onTopRated(TopRated event, Emitter<MoviesState> emit) async {
    await _fetchMovies(Endpoint.topRated, event.refresh, emit);
  }

  Future<void> _fetchMovies(
      Endpoint endpoint, bool refresh, Emitter<MoviesState> emit) async {
    final currentState = state;

    // Guard against duplicate fetching or when max pages reached
    if (!refresh &&
        currentState is Success &&
        (currentState.isLoading || currentState.hasReachedMax)) {
      return;
    }

    final (prevMovies, currentPage) = switch (currentState) {
      Success(:final movies, :final page) when !refresh => (movies, page),
      _ => (<Movie>[], 1)
    };

    // Set loading indicator
    if (currentState is Success && !refresh) {
      emit(currentState.copyWith(isLoading: true));
    } else {
      emit(Loading());
    }

    try {
      // Fetch data from remote api
      final results = await switch (endpoint) {
        Endpoint.nowPlaying => repository.getNowPlaying,
        Endpoint.popular => repository.getPopular,
        Endpoint.upcoming => repository.getUpcoming,
        Endpoint.topRated => repository.getTopRated,
      }(page: currentPage);

      if (results.isEmpty) {
        if (currentState is Success) {
          emit(currentState.copyWith(hasReachedMax: true, isLoading: false));
        }
        return;
      }

      // Deduplicate movies by ID
      final existingIds = prevMovies.map((m) => m.id).toSet();
      final newMovies =
          results.where((m) => !existingIds.contains(m.id)).toList();
      final updatedMovies = [...prevMovies, ...newMovies];

      // Clean cache
      if (refresh) clear();

      emit(Success(
        movies: updatedMovies,
        page: currentPage + 1,
        hasReachedMax: results.isEmpty,
        isLoading: false,
      ));
    } catch (e) {
      if (currentState is Success) {
        emit(currentState.copyWith(isLoading: false));
      } else {
        emit(Failure(message: e.toString()));
      }
    }
  }

  @override
  MoviesState? fromJson(Map<String, dynamic> json) {
    try {
      final rawData = json[key];
      if (rawData == null) return null;

      final Map<String, dynamic> moviesMap;
      int page = 1;
      bool hasReachedMax = false;

      if (rawData is Map<String, dynamic> && rawData.containsKey('movies')) {
        moviesMap = (rawData['movies'] as Map<String, dynamic>?) ?? {};
        page = (rawData['page'] as int?) ?? 1;
        hasReachedMax = (rawData['hasReachedMax'] as bool?) ?? false;
      } else if (rawData is Map<String, dynamic>) {
        // Fallback for legacy cache format
        moviesMap = rawData;
      } else {
        return null;
      }

      final movies = <Movie>[
        for (final movieJson in moviesMap.values) Movie.fromJson(movieJson),
      ];

      if (movies.isEmpty) return null;

      debugPrint(
          '${key.toUpperCase()} movies loaded from cache: ${movies.length} (next page: $page)');

      return Success(
        movies: movies,
        page: page,
        hasReachedMax: hasReachedMax,
      );
    } catch (e) {
      debugPrint('Error loading $key movies from cache: $e');
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(MoviesState state) {
    if (state is Success) {
      final Map<String, dynamic> cachedMovies = {};
      for (final movie in state.movies) {
        cachedMovies[movie.id.toString()] = movie.toJson();
      }

      debugPrint(
          '${key.toUpperCase()} movies saved to cache: ${cachedMovies.length} (next page: ${state.page})');

      return <String, dynamic>{
        key: {
          'movies': cachedMovies,
          'page': state.page,
          'hasReachedMax': state.hasReachedMax,
        },
      };
    }

    return null;
  }
}

class NowPlayingMoviesBloc extends MoviesBloc {
  NowPlayingMoviesBloc({required super.repository}) : super(key: 'nowPlaying');
}

class PopularMoviesBloc extends MoviesBloc {
  PopularMoviesBloc({required super.repository}) : super(key: 'popular');
}

class UpcomingMoviesBloc extends MoviesBloc {
  UpcomingMoviesBloc({required super.repository}) : super(key: 'upcoming');
}

class TopRatedMoviesBloc extends MoviesBloc {
  TopRatedMoviesBloc({required super.repository}) : super(key: 'topRated');
}
