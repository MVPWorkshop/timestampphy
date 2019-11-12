import 'package:flutter/material.dart';
import 'dart:io';

class ConfirmPictureScreenArgs {
  final String imagePath;

  ConfirmPictureScreenArgs({
    @required this.imagePath
  });
}

class ConfirmPictureScreen extends StatelessWidget {
  final ConfirmPictureScreenArgs args;

  const ConfirmPictureScreen(this.args);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.file(File(args.imagePath)),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
            Icons.check,
            color: Colors.lightBlueAccent
        ),
        backgroundColor: Colors.white,
        onPressed: () => {/*After pressed, hash picture, save it*/},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}