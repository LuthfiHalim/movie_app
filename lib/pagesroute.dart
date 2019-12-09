import 'package:flutter/material.dart';
import 'detail_screen.dart';
import 'home_screen.dart';

class Pages {
  static const Home = "/";
  static const Detail = "/detail";
}
class Router{
  Route<dynamic> getRoute(settings){
    Map<dynamic,dynamic> arguments = settings.arguments;

    switch (settings.name) {
      case Pages.Home :
        return _buildRoute(settings, HomeScreen());
      case Pages.Detail :
        return _buildRoute(settings, DetailScreen(movie : arguments['movie']));
      default:
        return null;
    }
  }
}

MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder){
  return MaterialPageRoute(
    builder: (ctx) => builder,
    settings: settings,
  );
}