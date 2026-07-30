import 'package:cinemapedia/data/datasources/moviedb_datasource.dart'
    show MovieDbDatasource;
import 'package:cinemapedia/data/repositories/movie_repository_impl.dart';
import 'package:cinemapedia/domain/repositories/movies_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:cinemapedia/config/router/app_router.dart';
import 'package:cinemapedia/config/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart' show GetIt;

// This is our global ServiceLocator
GetIt getIt = GetIt.instance;

// TODO: Move this to other file or class
void setupLocator() {
  getIt.registerSingleton<MoviesRepository>(
    MovieRepositoryImpl(datasource: MovieDbDatasource()),
    signalsReady: true,
  );
}

void main() async {
  await dotenv.load(fileName: '.env');
  setupLocator();
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
      routerConfig: appRouter,
    );
  }
}
