part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

class FetchMovies extends MovieEvent {}

class WatchListing extends MovieEvent {
  final int index;
  final bool watchList;
  const WatchListing({
    required this.index,
    required this.watchList,
  });
}

class SortMovies extends MovieEvent {
  final String sortby;

  const SortMovies(this.sortby);
}
