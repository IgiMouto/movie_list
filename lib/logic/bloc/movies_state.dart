part of 'movies_bloc.dart';

class MoviesState extends Equatable {
  const MoviesState({this.moviesModel});

  final MoviesModel? moviesModel;
  @override
  List<Object?> get props => [moviesModel];
  MoviesState copywith({MoviesModel? moviesModel}) {
    return MoviesState(moviesModel: moviesModel ?? this.moviesModel);
  }
}

class MoviesLoadedState extends MoviesState {
  MoviesLoadedState({required MoviesState state})
      : super(moviesModel: state.moviesModel);
}
