class PaginatedState<T> {
  PaginatedState({
    required this.items,
    required this.page,
    required this.hasNextPage,
  });

  final List<T> items;
  final int page;
  final bool hasNextPage;

  PaginatedState<T> copyWith({
    List<T>? items,
    int? page,
    bool? hasNextPage,
  }) {
    return PaginatedState(
      items: items ?? this.items,
      page: page ?? this.page,
      hasNextPage: hasNextPage ?? this.hasNextPage,
    );
  }
}
