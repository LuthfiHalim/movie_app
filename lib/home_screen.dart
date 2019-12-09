import 'package:flutter/material.dart';
import 'package:movie_app/movie.dart';
import 'package:movie_app/pagesroute.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Movie> popularMovies;
  List<Movie> nowPlayingMovies;
  List<Movie> topRatedMovies;
  List<Movie> upComingMovies;

  bool loading = true;

  getMovies() async {
    List<Movie> popular = await Movie.getListMoviePopular();
    List<Movie> nowplaying = await Movie.getListMovieNowPlaying();
    List<Movie> toprated = await Movie.getListMovieTopRated();
    List<Movie> upcoming = await Movie.getListMovieUpComing();
    setState(() {
      popularMovies = popular;
      nowPlayingMovies = nowplaying;
      topRatedMovies = toprated;
      upComingMovies = upcoming;
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text('Movie'),
            ),
            body: loading
                ? Text('loading')
                : ListView(
                    children: <Widget>[
                      MovieType(
                        type: 'Popular',
                      ),
                      MoviesCard(
                        movies: popularMovies,
                      ),
                      MovieType(
                        type: 'Now Playing',
                      ),
                      MoviesCard(
                        movies: nowPlayingMovies,
                      ),
                      MovieType(
                        type: 'Top Rated',
                      ),
                      MoviesCard(
                        movies: topRatedMovies,
                      ),
                      MovieType(
                        type: 'Up Coming',
                      ),
                      MoviesCard(
                        movies: upComingMovies,
                      ),
                    ],
                  )));
  }
}

class MovieType extends StatelessWidget {
  final String type;

  const MovieType({Key key, @required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: <Widget>[
          Text(type),
          Spacer(),
          Text('see all'),
          Icon(Icons.arrow_forward_ios)
        ],
      ),
    );
  }
}

class MoviesCard extends StatelessWidget {
  final List<Movie> movies;

  MoviesCard({@required this.movies});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Pages.Detail,
                      arguments: {'movie': movies[index]});
                },
                child: Card(
                    child: Container(
                        height: 240,
                        width: 120,
                        child: Column(
                          children: <Widget>[
                            Image.network(
                              'https://image.tmdb.org/t/p/w500${movies[index].posterPath}',
                              fit: BoxFit.fitWidth,
                            ),
                            Spacer(),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(movies[index].title),
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                                Text(movies[index].voteAverage.toString()),
                              ],
                            ),
                          ],
                        ))));
          }),
    );
  }
}
