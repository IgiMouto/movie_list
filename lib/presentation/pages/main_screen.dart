import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_list/logic/bloc/movie_bloc.dart';
import 'package:movie_list/presentation/pages/detailed_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        if (state is MovieLoadedState) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: screenWidth * 0.05),
                  child: Center(
                    child: GestureDetector(
                      onTap: () async {
                        final result = await showDialog<String>(
                            context: context,
                            builder: (context) {
                              return SimpleDialog(
                                title: const Text('Select Sorting Type'),
                                children: [
                                  SimpleDialogOption(
                                    onPressed: () {
                                      Navigator.pop<String>(context, 'title');
                                    },
                                    child: const Text('Sort By Title'),
                                  ),
                                  SimpleDialogOption(
                                    onPressed: () {
                                      Navigator.pop<String>(
                                          context, 'released_date');
                                    },
                                    child: const Text('Sort By Date'),
                                  ),
                                ],
                              );
                            });
                        if (result != null) {
                          context.read<MovieBloc>().add(SortMovies(result));
                          context.read<MovieBloc>().add(FetchMovies());
                        }
                      },
                      child: const Text(
                        "Sort",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            body: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Movies",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Flexible(
                    child: ListView.builder(
                        itemBuilder: (context, index) {
                          var movie = state.movies[index];
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    (context),
                                    MaterialPageRoute(
                                      builder: (_) {
                                        return BlocProvider.value(
                                          value: BlocProvider.of<MovieBloc>(
                                              context),
                                          child: DetailedScreen(
                                            movie: state.movies[index],
                                            index: index,
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Image.asset(
                                      movie['image'],
                                      height: 200,
                                      width: 100,
                                    ),
                                    const SizedBox(width: 20),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${movie["title"]}(${movie["released_date"].toString().split(',').first})",
                                            style: const TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 20),
                                          Text(
                                            "${movie["duration"]}-${movie["genre"]}",
                                            style: const TextStyle(
                                              color: Color(0xff808080),
                                              fontSize: 15,
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          Visibility(
                                            visible: movie["watchlist"],
                                            child: const Text(
                                              "ON MY WATCHLIST",
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              index == state.movies.length - 1
                                  ? Container()
                                  : const Divider(
                                      thickness: 2,
                                    ),
                            ],
                          );
                        },
                        itemCount: state.movies.length),
                  )
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
