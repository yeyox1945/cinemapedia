import 'package:cinemapedia/presentation/providers/actors/actors_repository_provider.dart'
    show actorsRepositoryProvider;
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'actors_by_movie_provider.g.dart';

@riverpod
Future<List<Actor>> actorsByMovie(Ref ref, String movieId) async {
  final actorsRepository = ref.watch(actorsRepositoryProvider);

  return await actorsRepository.getActorsByMovie(movieId);
}
