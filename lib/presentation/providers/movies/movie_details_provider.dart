import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../domain/entities/movie.dart';

part 'movie_details_provider.g.dart';

@riverpod
Future<Movie> movieDetails(Ref ref, String movieId) async {
  final movieRepo = ref.watch(movieRepositoryProvider);

  return movieRepo.getMovieById(movieId);
}
