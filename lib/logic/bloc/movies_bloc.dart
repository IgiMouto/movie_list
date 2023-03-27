import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_list/data/models/movies_model.dart';
import 'package:movie_list/data/repositories/movies_repository.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  MoviesBloc({required this.moviesRepository}) : super(const MoviesState()) {
    on<FetchMovies>(_onFetchMovies);
  }
  final MoviesRepository moviesRepository;
  FutureOr<void> _onFetchMovies(
      FetchMovies event, Emitter<MoviesState> emit) async {
    try {
      final moviesResponse = await moviesRepository.fetchMoviesData();
      emit(state.copywith(moviesModel: moviesResponse));
    } catch (e) {
      throw Exception();
    }
  }
}
