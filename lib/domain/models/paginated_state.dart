class PaginatedState<T> {
  PaginatedState({
    required this.items,
    required this.page,
    required this.hasNextPage,
    required this.isLoading,
  });

  final List<T> items;
  final int page;
  final bool hasNextPage;
  final bool isLoading;

  PaginatedState<T> copyWith({
    List<T>? items,
    int? page,
    bool? hasNextPage,
    bool? isLoading,
  }) {
    return PaginatedState(
      items: items ?? this.items,
      page: page ?? this.page,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
