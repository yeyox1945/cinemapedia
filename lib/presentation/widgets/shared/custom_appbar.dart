import 'package:cinemapedia/presentation/delegates/search_movie_delegate.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/movie.dart';

// TODO: search movies provider not working properly

class CustomAppbar extends ConsumerStatefulWidget {
  const CustomAppbar({super.key});

  @override
  ConsumerState<CustomAppbar> createState() => _CustomAppbarState();
}

class _CustomAppbarState extends ConsumerState<CustomAppbar> {
  late TextEditingController _queryController;

  @override
  void initState() {
    super.initState();
    _queryController = TextEditingController();
  }

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  Icon(
                    Icons.movie_outlined,
                    color: colors.primary,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'Cinemapedia',
                    style: titleStyle,
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        showSearch<Movie?>(
                          query: _queryController.text,
                          context: context,
                          delegate: SearchMovieDelegate(
                            initialMovies: [],
                            searchMovies: (query) async {
                              final movies =
                                  ref.read(searchQueryProvider(query));
                              return movies.value ?? [];
                            },
                          ),
                        ).then((movie) {
                          if (!context.mounted) return;
                          if (movie == null) return;
                          context.push('/movies/${movie.id}');
                        });
                      },
                      icon: const Icon(Icons.search))
                ],
              )),
        ));
  }
}
