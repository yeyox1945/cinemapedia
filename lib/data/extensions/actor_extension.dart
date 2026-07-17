import 'package:cinemapedia/data/models/moviedb/credits_response.dart';
import 'package:cinemapedia/domain/entities/actor.dart';

extension CastX on Cast {
  Actor toEntity() => Actor(
        id: id,
        name: name,
        profilePath: profilePath != null
            ? 'https://image.tmdb.org/t/p/w500$profilePath'
            : 'https://qph.cf2.quoracdn.net/main-qimg-f32f85d21d59a5540948c3bfbce52e68',
        character: character,
      );
}
