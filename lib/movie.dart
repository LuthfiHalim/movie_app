import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Movie{
  final int popularity; //304.753,
  final int voteCount; //687,
  final bool video;// false,
  final String posterPath; //: "/qdfARIhgpgZOBh3vfNhWS4hmSo3.jpg",
  final int id; //: 330457,
  final bool adult; //: false,
  final String backdropPath; //: "/xJWPZIYOEFIjZpBL7SVBGnzRYXp.jpg",
  final String originalLanguage; //: "en",
  final String originalTitle; //: "Frozen II",
  final List<dynamic> genreIds; //: [16,10402,10751],
  final String title; //: "Frozen II",
  final double voteAverage; //: 7,
  final String overview; //: "Elsa, Anna, Kristoff and Olaf head far into the forest to learn the truth about an ancient mystery of their kingdom.",
  final String releaseDate;

  Movie(this.popularity, this.voteCount, this.video, this.posterPath, this.id, this.adult, this.backdropPath, this.originalLanguage, this.originalTitle, this.genreIds, this.title, this.voteAverage, this.overview, this.releaseDate); //: "2019-11-20"

  Movie.fromJSON(Map<dynamic,dynamic> response)
        : popularity = int.parse(response['popularity'].toString().split('.').join('')),
          voteCount = response['vote_count'],
          video = response['video'],
          posterPath = response['poster_path'],
          id = response['id'],
          adult = response['adult'],
          backdropPath = response['backdrop_path'],
          originalLanguage = response['original_language'],
          originalTitle = response['original_title'],
          genreIds = response['genre_ids'],
          title = response['title'],
          voteAverage = double.parse(response['vote_average'].toString()),
          overview = response['overview'],
          releaseDate = response['release_date'];

  static getListMoviePopular()async{
    var response = await Dio().get("https://api.themoviedb.org/3/movie/popular?page=1&language=en-US&api_key=d3afb5ba2f51532b4d77bda3e1fba203");
    
    List<Movie> movies = (response.data['results'] as List).map((item){
        return Movie.fromJSON(item);
    }).toList();
    return movies;
  }
  static getListMovieNowPlaying()async{
    var response = await Dio().get("https://api.themoviedb.org/3/movie/now_playing?page=1&language=en-US&api_key=d3afb5ba2f51532b4d77bda3e1fba203");
    
    List<Movie> movies = (response.data['results'] as List).map((item){
        return Movie.fromJSON(item);
    }).toList();
    return movies;
  }
  static getListMovieTopRated()async{
    var response = await Dio().get("https://api.themoviedb.org/3/movie/top_rated?page=1&language=en-US&api_key=d3afb5ba2f51532b4d77bda3e1fba203");
    
    List<Movie> movies = (response.data['results'] as List).map((item){
        return Movie.fromJSON(item);
    }).toList();
    return movies;
  }
  static getListMovieUpComing()async{
    var response = await Dio().get("https://api.themoviedb.org/3/movie/upcoming?page=1&language=en-US&api_key=d3afb5ba2f51532b4d77bda3e1fba203");
    
    List<Movie> movies = (response.data['results'] as List).map((item){
        return Movie.fromJSON(item);
    }).toList();
    return movies;
  }

        
  
  // static getTodos() async {
  //   var response = 
  //       await Dio().get("https://address-book-exp-api.herokuapp.com/users");

  //   return todos;
  // }

  // static postTodo(data) async {
  //   var response = await Dio().post("https://address-book-exp-api.herokuapp.com/users", data: await data);
  //   return response;
  // }
  // static patchTodo(data, id) async {
  //   var response = await Dio().patch("https://address-book-exp-api.herokuapp.com/users/$id", data: data);
  //   return response;
  // }
  // static deleteTodos(id) async {
  //   var response = await Dio().delete("https://address-book-exp-api.herokuapp.com/users/$id");
  //   return response;
  // }
}