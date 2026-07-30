part of 'movies_bloc.dart';

@immutable
sealed class MoviesState extends Equatable {
  const MoviesState();

  @override
  List<Object> get props => [];
}

final class Initial extends MoviesState {}

final class Loading extends MoviesState {}

final class Success extends MoviesState {
  const Success({required this.movies});

  final List<Movie> movies;

  @override
  List<Object> get props => [movies];
}

final class Failure extends MoviesState {
  const Failure({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
