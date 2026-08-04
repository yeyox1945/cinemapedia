// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movies_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$moviesNotifierHash() => r'2554b6e6f701f5129d19cedd8fb7502369c72341';

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

abstract class _$MoviesNotifier
    extends BuildlessAutoDisposeAsyncNotifier<PaginatedState<Movie>> {
  late final MovieType movieType;

  FutureOr<PaginatedState<Movie>> build(
    MovieType movieType,
  );
}

/// See also [MoviesNotifier].
@ProviderFor(MoviesNotifier)
const moviesNotifierProvider = MoviesNotifierFamily();

/// See also [MoviesNotifier].
class MoviesNotifierFamily extends Family<AsyncValue<PaginatedState<Movie>>> {
  /// See also [MoviesNotifier].
  const MoviesNotifierFamily();

  /// See also [MoviesNotifier].
  MoviesNotifierProvider call(
    MovieType movieType,
  ) {
    return MoviesNotifierProvider(
      movieType,
    );
  }

  @override
  MoviesNotifierProvider getProviderOverride(
    covariant MoviesNotifierProvider provider,
  ) {
    return call(
      provider.movieType,
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
  String? get name => r'moviesNotifierProvider';
}

/// See also [MoviesNotifier].
class MoviesNotifierProvider extends AutoDisposeAsyncNotifierProviderImpl<
    MoviesNotifier, PaginatedState<Movie>> {
  /// See also [MoviesNotifier].
  MoviesNotifierProvider(
    MovieType movieType,
  ) : this._internal(
          () => MoviesNotifier()..movieType = movieType,
          from: moviesNotifierProvider,
          name: r'moviesNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$moviesNotifierHash,
          dependencies: MoviesNotifierFamily._dependencies,
          allTransitiveDependencies:
              MoviesNotifierFamily._allTransitiveDependencies,
          movieType: movieType,
        );

  MoviesNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.movieType,
  }) : super.internal();

  final MovieType movieType;

  @override
  FutureOr<PaginatedState<Movie>> runNotifierBuild(
    covariant MoviesNotifier notifier,
  ) {
    return notifier.build(
      movieType,
    );
  }

  @override
  Override overrideWith(MoviesNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: MoviesNotifierProvider._internal(
        () => create()..movieType = movieType,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        movieType: movieType,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<MoviesNotifier, PaginatedState<Movie>>
      createElement() {
    return _MoviesNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MoviesNotifierProvider && other.movieType == movieType;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, movieType.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin MoviesNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<PaginatedState<Movie>> {
  /// The parameter `movieType` of this provider.
  MovieType get movieType;
}

class _MoviesNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<MoviesNotifier,
        PaginatedState<Movie>> with MoviesNotifierRef {
  _MoviesNotifierProviderElement(super.provider);

  @override
  MovieType get movieType => (origin as MoviesNotifierProvider).movieType;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
