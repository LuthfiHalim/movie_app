import 'package:flutter/material.dart';
import 'package:movie_app/movie.dart';

class DetailScreen extends StatelessWidget {
  final Movie movie;

  const DetailScreen({Key key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Image.network('https://image.tmdb.org/t/p/w500${movie.backdropPath}'),
        Container(
          margin: EdgeInsets.fromLTRB(10, 200, 10, 0),
          child: Material(
            color: Colors.grey,
          borderRadius: BorderRadius.circular(15),
          child: Container(
            margin: EdgeInsets.all(10),
            height: 420,
            width: 280,
            child: Column(
              children: <Widget>[
                Image.network(
                    'https://image.tmdb.org/t/p/w500${movie.posterPath}'),
              ],
            ),
          ),
        ))
      ],
    ));
  }
}
