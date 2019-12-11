import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/movie.dart';
import 'package:movie_app/pagesroute.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

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

  _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        //_showItemDialog(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        //_navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        //_navigateToItemDetail(message);
      },
    );
    // _firebaseMessaging.requestNotificationPermissions(
    //     const IosNotificationSettings(sound: true, badge: true, alert: true));
    // _firebaseMessaging.onIosSettingsRegistered
    //     .listen((IosNotificationSettings settings) {
    //   print("Settings registered: $settings");
    // });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      setState(() {
      });
      print(token);

    });



  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.grey,
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: Text(
                'Movies',
                style: TextStyle(color: Colors.white, fontSize: 26),
                textAlign: TextAlign.center,
              ),
            ),
            body: loading
                ? Center(child:CircularProgressIndicator(backgroundColor: Colors.black,))
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
          Text('   $type', style: TextStyle(fontSize: 24)),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 120,
                              height: 180,
                              child: Image.network(
                                'https://image.tmdb.org/t/p/w500${movies[index].posterPath}',
                                fit: BoxFit.fitWidth,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress
                                                  .expectedTotalBytes !=
                                              null
                                          ? loadingProgress
                                                  .cumulativeBytesLoaded /
                                              loadingProgress.expectedTotalBytes
                                          : null,
                                    ),
                                  );
                                },
                              ),
                            ),
                            Spacer(flex: 1,),
                            Expanded(
                              flex: 5,
                              child: Text(
                                movies[index].title,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Row(
                                children: <Widget>[
                                  Spacer(flex: 4,),
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                  Text(movies[index].voteAverage.toString()),
                                  Spacer(flex: 1,)
                                ],
                              ),
                            ),
                            Spacer(flex: 1,)
                          ],
                        ))));
          }),
    );
  }
}
