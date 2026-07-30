part of 'movies_bloc.dart';

@immutable
sealed class MoviesEvent {}

base class _Fetch extends MoviesEvent {
  _Fetch({this.query});

  final String? query;
}

final class NowPlaying extends _Fetch {
  NowPlaying({super.query});
}

final class Popular extends _Fetch {
  Popular({super.query});
}

final class Upcoming extends _Fetch {
  Upcoming({super.query});
}

final class TopRated extends _Fetch {
  TopRated({super.query});
}
