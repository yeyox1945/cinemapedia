import 'package:cinemapedia/data/datasources/moviedb_datasource.dart';
import 'package:cinemapedia/data/repositories/movie_repository_impl.dart';
import 'package:cinemapedia/domain/repositories/movies_repository.dart';
import 'package:cinemapedia/presentation/providers/api/dio_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'movies_repository_provider.g.dart';

@riverpod
MoviesRepository movieRepository(Ref ref) {
  final dio = ref.read(dioProvider);
  return MovieRepositoryImpl(datasource: MovieDbDatasource(dio: dio));
}
