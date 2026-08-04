import 'package:cinemapedia/data/datasources/actor_moviedb_datasource.dart';
import 'package:cinemapedia/data/repositories/actor_repository_impl.dart';
import 'package:cinemapedia/domain/repositories/actors_repository.dart';
import 'package:cinemapedia/presentation/providers/api/dio_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'actors_repository_provider.g.dart';

@riverpod
ActorsRepository actorsRepository(Ref ref) {
  final dio = ref.watch(authedDioProvider);

  return ActorRepositoryImpl(ActorMovieDbDatasource(dio: dio));
}
