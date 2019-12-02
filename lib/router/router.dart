import 'package:flutter/material.dart';
import 'package:timestampphy/ui/screens/home/home_screen.dart';
import 'package:timestampphy/ui/screens/take_picture/take_picture_screen.dart';
import 'package:timestampphy/ui/screens/confirm_picture/confirm_picture_screen.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final routeName = settings.name;

    switch(routeName) {
      case Routes.TakePictureScreen:
        return MaterialPageRoute(builder: (context) => TakePictureScreen());

      case Routes.ConfirmPictureScreen:
        final ConfirmPictureScreenArgs args = settings.arguments;
        return MaterialPageRoute(
            builder: (context) => ConfirmPictureScreen(args)
        );

      default:
        return MaterialPageRoute(builder: (context) => HomeScreen());
    }
  }
}

class Routes {
  static const String HomeScreen = "/";
  static const String TakePictureScreen = "camera/take_picture";
  static const String ConfirmPictureScreen = "camera/confirm_picture";
}