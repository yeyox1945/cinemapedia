part of 'actor_bloc.dart';

enum ActorStatus { initial, success, failure }

class ActorState extends Equatable {
  final ActorStatus status;
  final List<Actor> actors;

  const ActorState({
    this.status = ActorStatus.initial,
    required this.actors,
  });

  ActorState copyWith({
    ActorStatus? status,
    List<Actor>? actors,
  }) {
    return ActorState(
      status: status ?? this.status,
      actors: actors ?? this.actors,
    );
  }

  @override
  List<Object?> get props => [status, actors];
}
