import 'package:flutter/material.dart';
import 'package:movie_app/pagesroute.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Forms in Flutter',
      theme: ThemeData(
        primarySwatch: Colors.red
      ),
      initialRoute: Pages.Home,
      onGenerateRoute: Router().getRoute,
    );
  }
}