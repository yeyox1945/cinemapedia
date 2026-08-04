import 'package:cinemapedia/config/constants/environment.dart' show Environment;
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' show Ref;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_provider.g.dart';

@riverpod
Dio dio(Ref ref) {
  return Dio(
      BaseOptions(baseUrl: 'https://api.themoviedb.org/3', queryParameters: {
    'api_key': Environment.movieDbKey,
    'language': 'es-MX',
  }));
}

@riverpod
Dio authedDio(Ref ref) {
  final dio = ref.watch(dioProvider);

  // If the auth state changes then the this provider wont have the right auth token and thus any protected endpoint will fail
  // final authState = ref.watch(authProvider);

  // final token = switch (authState) {
  //   Authenticated() => 'authenticated token here',
  //   _ => 'no token',
  // };

  // if (token != null) {
  //   dio.options.headers['Authorization'] = 'Bearer $token';
  // } else {
  //   dio.options.headers.remove('Authorization');
  // }

  return dio;
}
