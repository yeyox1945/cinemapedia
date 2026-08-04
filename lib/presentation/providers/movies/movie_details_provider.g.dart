// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_details_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$movieDetailsHash() => r'6c903ee7f68da4fd611f7c60fa7f9187e25ca4ec';

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

/// See also [movieDetails].
@ProviderFor(movieDetails)
const movieDetailsProvider = MovieDetailsFamily();

/// See also [movieDetails].
class MovieDetailsFamily extends Family<AsyncValue<Movie>> {
  /// See also [movieDetails].
  const MovieDetailsFamily();

  /// See also [movieDetails].
  MovieDetailsProvider call(
    String movieId,
  ) {
    return MovieDetailsProvider(
      movieId,
    );
  }

  @override
  MovieDetailsProvider getProviderOverride(
    covariant MovieDetailsProvider provider,
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
  String? get name => r'movieDetailsProvider';
}

/// See also [movieDetails].
class MovieDetailsProvider extends AutoDisposeFutureProvider<Movie> {
  /// See also [movieDetails].
  MovieDetailsProvider(
    String movieId,
  ) : this._internal(
          (ref) => movieDetails(
            ref as MovieDetailsRef,
            movieId,
          ),
          from: movieDetailsProvider,
          name: r'movieDetailsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$movieDetailsHash,
          dependencies: MovieDetailsFamily._dependencies,
          allTransitiveDependencies:
              MovieDetailsFamily._allTransitiveDependencies,
          movieId: movieId,
        );

  MovieDetailsProvider._internal(
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
    FutureOr<Movie> Function(MovieDetailsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MovieDetailsProvider._internal(
        (ref) => create(ref as MovieDetailsRef),
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
  AutoDisposeFutureProviderElement<Movie> createElement() {
    return _MovieDetailsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MovieDetailsProvider && other.movieId == movieId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, movieId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin MovieDetailsRef on AutoDisposeFutureProviderRef<Movie> {
  /// The parameter `movieId` of this provider.
  String get movieId;
}

class _MovieDetailsProviderElement
    extends AutoDisposeFutureProviderElement<Movie> with MovieDetailsRef {
  _MovieDetailsProviderElement(super.provider);

  @override
  String get movieId => (origin as MovieDetailsProvider).movieId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
