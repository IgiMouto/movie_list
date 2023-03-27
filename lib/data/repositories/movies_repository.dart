import 'package:flutter/services.dart';
import 'package:movie_list/data/models/movies_model.dart';

class MoviesRepository {
  Future<MoviesModel> fetchMoviesData() async {
    dynamic response =
        await rootBundle.loadString('assets/data/movie_data.json');

    return moviesModelFromJson(response);
  }
}
