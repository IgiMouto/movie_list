import 'package:movie_list/data/globals.dart';

class MovieRepository {
  Future<List<Map<String, dynamic>>>? fetchData() async {
    final response = listOfMovies;

    return response;
  }

  Future<List<Map<String, dynamic>>>? updateData(
      {required int index, required bool watchList}) async {
    final response = listOfMovies;
    if (response[index]['watchlist'] == true) {
      response[index]['watchlist'] = false;
    } else {
      response[index]['watchlist'] = true;
    }
    return response;
  }

  Future<List<Map<String, dynamic>>>? sortData({required String sortby}) async {
    final response = listOfMovies;
    if (sortby == "title") {
      response.sort((a, b) => a['title'].compareTo(b['title']));
    } else {
      response.sort((a, b) => a['released_date'].compareTo(b['released_date']));
    }
    return response;
  }
}
