import 'package:cinemapedia/data/datasources/movies/movies_remote_datasource.dart'
    show MoviesRemoteDatasource;
import 'package:cinemapedia/data/repositories/movie_repository_impl.dart';
import 'package:cinemapedia/domain/repositories/movies_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:cinemapedia/config/router/app_router.dart';
import 'package:cinemapedia/config/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart' show GetIt;
import 'package:hydrated_bloc/hydrated_bloc.dart'
    show HydratedBloc, HydratedStorage, HydratedStorageDirectory;
import 'package:path_provider/path_provider.dart';

// This is our global ServiceLocator
GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerSingleton<MoviesRepository>(
    MovieRepositoryImpl(datasource: MoviesRemoteDatasource()),
    signalsReady: true,
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorageDirectory.web
          : HydratedStorageDirectory((await getTemporaryDirectory()).path));
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
