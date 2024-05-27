import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/repositories/actor_repository_impl.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'actor_event.dart';
part 'actor_state.dart';

class ActorBloc extends Bloc<ActorEvent, ActorState> {
  final ActorRepositoryImpl actorRepository;

  ActorBloc({required this.actorRepository})
      : super(const ActorState(actors: [])) {
    on<GetActorsByMovieEvent>(_onGetActorsByMovie);
  }

  Future _onGetActorsByMovie(
      GetActorsByMovieEvent event, Emitter<ActorState> emit) async {
    final List<Actor> actors =
        await actorRepository.getActorsByMovie(event.movieId);
    emit(state.copyWith(status: ActorStatus.success, actors: actors));
  }
}
