import 'package:cinemapedia/data/models/moviedb/movie_details_response.dart'
    show MovieDetails;
import 'package:cinemapedia/domain/entities/movie.dart' show Movie;

extension MovieDetailsX on MovieDetails {
  Movie toEntity() => Movie(
        adult: adult,
        backdropPath: backdropPath != ''
            ? 'https://image.tmdb.org/t/p/w500$backdropPath'
            : 'https://linnea.com.ar/wp-content/uploads/2018/09/404PosterNotFound.jpg',
        genreIds: genres.map((e) => e.name).toList(),
        id: id,
        originalLanguage: originalLanguage,
        originalTitle: originalTitle,
        overview: overview,
        popularity: popularity,
        posterPath: posterPath != ''
            ? 'https://image.tmdb.org/t/p/w500$posterPath'
            : 'https://linnea.com.ar/wp-content/uploads/2018/09/404PosterNotFound.jpg',
        releaseDate: releaseDate,
        title: title,
        video: video,
        voteAverage: voteAverage,
        voteCount: voteCount,
      );
}
