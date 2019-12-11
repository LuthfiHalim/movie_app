import 'package:flutter/material.dart';
import 'package:movie_app/movie.dart';

class DetailScreen extends StatelessWidget {
  final Movie movie;

  const DetailScreen({Key key, this.movie}) : super(key: key);

  textDivider() => Row(children: <Widget>[
        Expanded(
          child: new Container(
              margin: const EdgeInsets.only(left: 10.0, right: 20.0),
              child: Divider(
                color: Colors.black,
                height: 36,
              )),
        ),
        Text("Description"),
        Expanded(
          child: new Container(
              margin: const EdgeInsets.only(left: 20.0, right: 10.0),
              child: Divider(
                color: Colors.black,
                height: 36,
              )),
        ),
      ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            Container(
                child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(),
                ),
                Opacity(
                  opacity: 0.7,
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                    fit: BoxFit.fitWidth,
                  ),
                )
              ],
            )),
            Image.network(
              'https://image.tmdb.org/t/p/w500${movie.backdropPath}',
              fit: BoxFit.fitWidth,
            ),
            Positioned(
                left: MediaQuery.of(context).size.width / 20 * 2,
                top: MediaQuery.of(context).size.height / 40 * 8,
                child: Card(
                  elevation: 10,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  //borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width / 20 * 1,
                        MediaQuery.of(context).size.height / 40 * 2,
                        MediaQuery.of(context).size.width / 20 * 1,
                        MediaQuery.of(context).size.height / 40 * 2),
                    color: Colors.transparent,
                    height: MediaQuery.of(context).size.height / 40 * 24,
                    width: MediaQuery.of(context).size.width / 20 * 16,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Image.network(
                                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                    fit: BoxFit.fitHeight),
                              ),
                              Expanded(
                                  child: Column(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      movie.title,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  //Spacer(),
                                  Expanded(
                                    child: CircleAvatar(
                                      backgroundColor:
                                          chooseColor(movie.voteAverage),
                                      child: Text(movie.voteAverage.toString()),
                                    ),
                                  ),
                                  //Spacer(),
                                  Text('Released Date :',overflow: TextOverflow.ellipsis,),
                                  Text(movie.releaseDate,overflow: TextOverflow.ellipsis),
                                ],
                              )),
                            ],
                          ),
                        ),
                        textDivider(),
                        Expanded(
                          child: Text(
                            movie.overview,
                            textAlign: TextAlign.justify,
                          ),
                        )
                      ],
                    ),
                  ),
                )),
          ],
        ));
  }
}

MaterialColor chooseColor(double value) {
  if (value < 6) {
    return Colors.red;
  } else if (value < 7.5) {
    return Colors.yellow;
  } else {
    return Colors.green;
  }
}
