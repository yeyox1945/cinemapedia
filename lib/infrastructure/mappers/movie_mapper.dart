import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_response.dart';

class MovieMapper {
  static Movie movieDbToEntity(MovieMovieDB movieDb) => Movie(
      adult: movieDb.adult,
      backdropPath: movieDb.backdropPath != ''
          ? 'https://image.tmdb.org/t/p/w500${movieDb.backdropPath}'
          : 'https://linnea.com.ar/wp-content/uploads/2018/09/404PosterNotFound.jpg',
      genreIds: movieDb.genreIds.map((e) => e.toString()).toList(),
      id: movieDb.id,
      originalLanguage: movieDb.originalLanguage,
      originalTitle: movieDb.originalTitle,
      overview: movieDb.overview,
      popularity: movieDb.popularity,
      posterPath: movieDb.posterPath != '' ? 'https://image.tmdb.org/t/p/w500${movieDb.posterPath}' : 'no-poster',
      releaseDate: movieDb.releaseDate,
      title: movieDb.title,
      video: movieDb.video,
      voteAverage: movieDb.voteAverage,
      voteCount: movieDb.voteCount);
}
