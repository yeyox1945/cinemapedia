part of 'actor_bloc.dart';

sealed class ActorEvent {}

class GetActorsByMovieEvent extends ActorEvent {
  final String movieId;

  GetActorsByMovieEvent(this.movieId);
}
