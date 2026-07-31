part of 'movies_bloc.dart';

@immutable
sealed class MoviesEvent {}

class _Fetch extends MoviesEvent {
  _Fetch({this.refresh = false});

  final bool? refresh;
}

final class NowPlaying extends _Fetch {
  NowPlaying({super.refresh});
}

final class Popular extends _Fetch {
  Popular({super.refresh});
}

final class Upcoming extends _Fetch {
  Upcoming({super.refresh});
}

final class TopRated extends _Fetch {
  TopRated({super.refresh});
}
