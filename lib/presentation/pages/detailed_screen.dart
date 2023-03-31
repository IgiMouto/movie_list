import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_list/logic/bloc/movie_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailedScreen extends StatelessWidget {
  const DetailedScreen({super.key, required this.index, required this.movie});
  final Map<String, dynamic> movie;
  final int index;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        if (state is MovieLoadedState) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 1,
              foregroundColor: Colors.black,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 200,
                        width: 120,
                        child: Image.asset(
                          movie["image"],
                          fit: BoxFit.fill,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  child: Text(movie["title"]),
                                ),
                                Text("${movie["rating"]}/10"),
                              ],
                            ),
                            const SizedBox(height: 30),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(30)),
                              child: GestureDetector(
                                onTap: () async {
                                  context.read<MovieBloc>().add(WatchListing(
                                      index: index,
                                      watchList: movie['watchlist']));
                                  context.read<MovieBloc>().add(FetchMovies());
                                },
                                child: state.movies[index]['watchlist'] == false
                                    ? const Text("+ ADD TO WATCHLIST")
                                    : const Text("REMOVE FROM WATCHLIST"),
                              ),
                            ),
                            const SizedBox(height: 15),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    side: const BorderSide()),
                                onPressed: () async {
                                  var uri = Uri.parse(movie['trailer_link']);

                                  if (await canLaunchUrl(uri)) {
                                    await launchUrl(uri);
                                  } else {
                                    throw 'Could not launch $uri';
                                  }
                                },
                                child: const Text("WATCH TRAILER"))
                          ],
                        ),
                      )
                    ],
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  const Text("Sort Description"),
                  Flexible(
                    child: Text(movie["description"]),
                  ),
                  const Divider(),
                  const Text("Details"),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: const [
                            Text(
                              "Genre",
                            ),
                            Text("Released Date"),
                          ],
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(movie["genre"]),
                            Text(movie["released_date"]),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
