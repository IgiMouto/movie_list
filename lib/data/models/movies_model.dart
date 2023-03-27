// To parse this JSON data, do
//
//     final moviesModel = moviesModelFromJson(jsonString);

import 'dart:convert';

MoviesModel moviesModelFromJson(String str) =>
    MoviesModel.fromJson(json.decode(str));

String moviesModelToJson(MoviesModel data) => json.encode(data.toJson());

class MoviesModel {
  MoviesModel({
    required this.movies,
  });

  List<Movie> movies;

  factory MoviesModel.fromJson(Map<String, dynamic> json) => MoviesModel(
        movies: List<Movie>.from(json["movies"].map((x) => Movie.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "movies": List<dynamic>.from(movies.map((x) => x.toJson())),
      };
}

class Movie {
  Movie({
    required this.title,
    required this.description,
    required this.rating,
    required this.duration,
    required this.genre,
    required this.releasedDate,
    required this.trailerLink,
    required this.image,
  });

  String title;
  String description;
  String rating;
  String duration;
  String genre;
  String releasedDate;
  String trailerLink;
  String image;

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        title: json["title"],
        description: json["description"],
        rating: json["rating"],
        duration: json["duration"],
        genre: json["genre"],
        releasedDate: json["released_date"],
        trailerLink: json["trailer_link"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "rating": rating,
        "duration": duration,
        "genre": genre,
        "released_date": releasedDate,
        "trailer_link": trailerLink,
        "image": image,
      };
}
