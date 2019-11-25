import 'dart:io';
import 'package:flutter/material.dart';
import 'package:timestampphy/core/bloc/bloc_provider.dart';
import 'package:timestampphy/core/bloc/picture_bloc.dart';
import 'package:timestampphy/router/router.dart';

class ConfirmPictureScreenArgs {
  final String picturePath;

  ConfirmPictureScreenArgs({@required this.picturePath});
}

class ConfirmPictureScreen extends StatelessWidget {
  final ConfirmPictureScreenArgs args;

  const ConfirmPictureScreen(this.args);

  void navigateToHome(context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.HomeScreen, (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    PictureBloc pictureBloc = BlocProvider.of<PictureBloc>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Image.file(File(args.picturePath)),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FlatButton(
            onPressed: () => navigateToHome(context),
            splashColor: Theme.of(context).accentColor,
            child: Container(
                padding: EdgeInsets.all(10),
                child: Icon(Icons.close, color: Colors.white)),
          ),
          SizedBox(width: 50),
          FloatingActionButton(
            child: Icon(Icons.check, color: Colors.white),
            backgroundColor: Theme.of(context).accentColor,
            onPressed: () {
              pictureBloc.addNewPicture(args.picturePath);
              navigateToHome(context);
            },
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
