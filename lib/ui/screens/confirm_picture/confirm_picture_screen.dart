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

  @override
  Widget build(BuildContext context) {
    PictureBloc pictureBloc = BlocProvider.of<PictureBloc>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.file(File(args.picturePath)),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check, color: Colors.lightBlueAccent),
        backgroundColor: Colors.white,
        onPressed: () {
          pictureBloc.addNewPicture(args.picturePath);
          Navigator.pushNamed(context, Routes.HomeScreen);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
