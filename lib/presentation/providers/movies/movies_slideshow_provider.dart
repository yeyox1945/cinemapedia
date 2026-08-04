import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'movies_slideshow_provider.g.dart';

@riverpod
Future<List<Movie>> moviesSlideshow(Ref ref) async {
  final moviesState = ref.watch(moviesNotifierProvider(MovieType.nowPlaying));

  return moviesState.value?.items.take(6).toList() ?? [];
}
