import 'package:flutter/material.dart';
import 'package:timestampphy/router/Router.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timestampphy',
      initialRoute: '/',
      onGenerateRoute: Router.generateRoute,
    );
  }
}

