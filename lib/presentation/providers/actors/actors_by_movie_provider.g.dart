// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actors_by_movie_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$actorsByMovieHash() => r'085f4a3c3ce83c57cd4175f9d26b9f9c6b71aaed';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [actorsByMovie].
@ProviderFor(actorsByMovie)
const actorsByMovieProvider = ActorsByMovieFamily();

/// See also [actorsByMovie].
class ActorsByMovieFamily extends Family<AsyncValue<List<Actor>>> {
  /// See also [actorsByMovie].
  const ActorsByMovieFamily();

  /// See also [actorsByMovie].
  ActorsByMovieProvider call(
    String movieId,
  ) {
    return ActorsByMovieProvider(
      movieId,
    );
  }

  @override
  ActorsByMovieProvider getProviderOverride(
    covariant ActorsByMovieProvider provider,
  ) {
    return call(
      provider.movieId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'actorsByMovieProvider';
}

/// See also [actorsByMovie].
class ActorsByMovieProvider extends AutoDisposeFutureProvider<List<Actor>> {
  /// See also [actorsByMovie].
  ActorsByMovieProvider(
    String movieId,
  ) : this._internal(
          (ref) => actorsByMovie(
            ref as ActorsByMovieRef,
            movieId,
          ),
          from: actorsByMovieProvider,
          name: r'actorsByMovieProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$actorsByMovieHash,
          dependencies: ActorsByMovieFamily._dependencies,
          allTransitiveDependencies:
              ActorsByMovieFamily._allTransitiveDependencies,
          movieId: movieId,
        );

  ActorsByMovieProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.movieId,
  }) : super.internal();

  final String movieId;

  @override
  Override overrideWith(
    FutureOr<List<Actor>> Function(ActorsByMovieRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ActorsByMovieProvider._internal(
        (ref) => create(ref as ActorsByMovieRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        movieId: movieId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Actor>> createElement() {
    return _ActorsByMovieProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ActorsByMovieProvider && other.movieId == movieId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, movieId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ActorsByMovieRef on AutoDisposeFutureProviderRef<List<Actor>> {
  /// The parameter `movieId` of this provider.
  String get movieId;
}

class _ActorsByMovieProviderElement
    extends AutoDisposeFutureProviderElement<List<Actor>>
    with ActorsByMovieRef {
  _ActorsByMovieProviderElement(super.provider);

  @override
  String get movieId => (origin as ActorsByMovieProvider).movieId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
