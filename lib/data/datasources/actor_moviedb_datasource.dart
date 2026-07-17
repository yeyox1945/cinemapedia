import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/data/extensions/actor_extension.dart';
import 'package:cinemapedia/data/models/moviedb/credits_response.dart';
import 'package:dio/dio.dart';

class ActorMovieDbDatasource extends ActorsDatasource {
  final dio = Dio(
      BaseOptions(baseUrl: 'https://api.themoviedb.org/3', queryParameters: {
    'api_key': Environment.movieDbKey,
    'language': 'es-MX',
  }));

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    final resp = await dio.get('/movie/$movieId/credits');

    final castResponse = CreditsResponse.fromJson(resp.data);

    final List<Actor> actors =
        castResponse.cast.map((cast) => cast.toEntity()).toList();

    return actors;
  }
}
