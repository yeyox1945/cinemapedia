// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_movies_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$searchQueryHash() => r'06c26dd8214fd4a56b41322590157cd15ee907a3';

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

/// See also [searchQuery].
@ProviderFor(searchQuery)
const searchQueryProvider = SearchQueryFamily();

/// See also [searchQuery].
class SearchQueryFamily extends Family<AsyncValue<List<Movie>>> {
  /// See also [searchQuery].
  const SearchQueryFamily();

  /// See also [searchQuery].
  SearchQueryProvider call(
    String query,
  ) {
    return SearchQueryProvider(
      query,
    );
  }

  @override
  SearchQueryProvider getProviderOverride(
    covariant SearchQueryProvider provider,
  ) {
    return call(
      provider.query,
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
  String? get name => r'searchQueryProvider';
}

/// See also [searchQuery].
class SearchQueryProvider extends AutoDisposeFutureProvider<List<Movie>> {
  /// See also [searchQuery].
  SearchQueryProvider(
    String query,
  ) : this._internal(
          (ref) => searchQuery(
            ref as SearchQueryRef,
            query,
          ),
          from: searchQueryProvider,
          name: r'searchQueryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$searchQueryHash,
          dependencies: SearchQueryFamily._dependencies,
          allTransitiveDependencies:
              SearchQueryFamily._allTransitiveDependencies,
          query: query,
        );

  SearchQueryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
  }) : super.internal();

  final String query;

  @override
  Override overrideWith(
    FutureOr<List<Movie>> Function(SearchQueryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SearchQueryProvider._internal(
        (ref) => create(ref as SearchQueryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Movie>> createElement() {
    return _SearchQueryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchQueryProvider && other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SearchQueryRef on AutoDisposeFutureProviderRef<List<Movie>> {
  /// The parameter `query` of this provider.
  String get query;
}

class _SearchQueryProviderElement
    extends AutoDisposeFutureProviderElement<List<Movie>> with SearchQueryRef {
  _SearchQueryProviderElement(super.provider);

  @override
  String get query => (origin as SearchQueryProvider).query;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
