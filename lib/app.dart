import 'package:flutter/material.dart';
import 'package:timestampphy/core/bloc/bloc_provider.dart';
import 'package:timestampphy/core/bloc/picture_bloc.dart';
import 'package:timestampphy/router/router.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: PictureBloc(),
      child: MaterialApp(
        title: 'Timestampphy',
        initialRoute: '/',
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}

