import 'package:bloc/bloc.dart';
import 'package:cinemapedia/domain/entities/movie.dart' show Movie;
import 'package:cinemapedia/domain/repositories/movies_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'movies_event.dart';
part 'movies_state.dart';

enum Endpoint {
  nowPlaying,
  popular,
  upcoming,
  topRated,
}

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  MoviesBloc({required this.repository}) : super(Initial()) {
    on<NowPlaying>(_onNowPlaying);
    on<Popular>(_onPopular);
    on<Upcoming>(_onUpcoming);
    on<TopRated>(_onTopRated);
  }
  final MoviesRepository repository;
  int page = 1;

  Future<void> _onNowPlaying(
      NowPlaying event, Emitter<MoviesState> emit) async {
    await _fetchMovies(Endpoint.nowPlaying, emit);
  }

  Future<void> _onPopular(Popular event, Emitter<MoviesState> emit) async {
    await _fetchMovies(Endpoint.popular, emit);
  }

  Future<void> _onUpcoming(Upcoming event, Emitter<MoviesState> emit) async {
    await _fetchMovies(Endpoint.upcoming, emit);
  }

  Future<void> _onTopRated(TopRated event, Emitter<MoviesState> emit) async {
    await _fetchMovies(Endpoint.topRated, emit);
  }

  Future<void> _fetchMovies(
      Endpoint endpoint, Emitter<MoviesState> emit) async {
    if (page == 1) {
      emit(Loading());
    }

    final results = await switch (endpoint) {
      Endpoint.nowPlaying => repository.getNowPlaying,
      Endpoint.popular => repository.getPopular,
      Endpoint.upcoming => repository.getUpcoming,
      Endpoint.topRated => repository.getTopRated,
    }(page: page);

    if (results.isEmpty) {
      emit(state);
      return;
    }

    final prevMovies = switch (state) {
      Success(movies: final movies) => movies,
      _ => <Movie>[],
    };

    emit(Success(movies: [...prevMovies, ...results]));
    page++;
  }
}
