import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_list/data/repositories/movies_repository.dart';
import 'package:movie_list/logic/bloc/movie_bloc.dart';
import 'package:movie_list/presentation/pages/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => MovieRepository(),
      child: BlocProvider(
        create: (context) =>
            MovieBloc(context.read<MovieRepository>())..add(FetchMovies()),
        child: const MaterialApp(
          home: MainScreen(),
        ),
      ),
    );
  }
}
