part of 'movies_bloc.dart';

@immutable
sealed class MoviesState extends Equatable {
  const MoviesState();

  @override
  List<Object?> get props => [];
}

final class Initial extends MoviesState {}

final class Loading extends MoviesState {}

final class Success extends MoviesState {
  const Success({
    required this.movies,
    this.page = 1,
    this.hasReachedMax = false,
    this.isLoading = false,
  });

  final List<Movie> movies;
  final int page;
  final bool hasReachedMax;
  final bool isLoading;

  Success copyWith({
    List<Movie>? movies,
    int? page,
    bool? hasReachedMax,
    bool? isLoading,
  }) {
    return Success(
      movies: movies ?? this.movies,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [movies, page, hasReachedMax, isLoading];
}

final class Failure extends MoviesState {
  const Failure({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
