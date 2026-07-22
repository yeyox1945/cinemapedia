import 'package:cinemapedia/data/datasources/moviedb_datasource.dart';
import 'package:cinemapedia/data/repositories/movie_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Repositorio inmutable de solo lectura
final movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImpl(datasource: MovieDbDatasource());
});
