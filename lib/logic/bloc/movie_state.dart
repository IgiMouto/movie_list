part of 'movie_bloc.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class MovieInitial extends MovieState {}

class MovieLoadedState extends MovieState {
  final List<Map<String, dynamic>> movies;
  const MovieLoadedState({
    required this.movies,
  });
}

class MovieLoadingState extends MovieState {}
