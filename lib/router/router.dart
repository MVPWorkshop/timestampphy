import 'package:flutter/material.dart';
import 'package:timestampphy/ui/screens/home/home_screen.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final routeName = settings.name;

    switch(routeName) {
      default:
        return MaterialPageRoute(builder: (context) => HomeScreen());
    }
  }
}

class Routes {
  static const String HomeScreen = "/";
}