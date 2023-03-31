import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_list/data/repositories/movies_repository.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc(this.movieRepository) : super(MovieInitial()) {
    on<FetchMovies>(_onFetchMovies);
    on<WatchListing>(_onWatchListing);
    on<SortMovies>(_onSortMovies);
  }
  final MovieRepository movieRepository;
  FutureOr<void> _onFetchMovies(
      FetchMovies event, Emitter<MovieState> emit) async {
    emit(MovieLoadingState());

    final response = await movieRepository.fetchData();
    if (response != null) {
      emit(MovieLoadedState(movies: response));
    }
  }

  FutureOr<void> _onWatchListing(
      WatchListing event, Emitter<MovieState> emit) async {
    emit(MovieLoadingState());

    final response = await movieRepository.updateData(
        index: event.index, watchList: event.watchList);
    if (response != null) {
      emit(MovieLoadedState(movies: response));
    }
  }

  FutureOr<void> _onSortMovies(
      SortMovies event, Emitter<MovieState> emit) async {
    emit(MovieLoadingState());

    final response = await movieRepository.sortData(sortby: event.sortby);
    if (response != null) {
      emit(MovieLoadedState(movies: response));
    }
  }
}
