import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:timestampphy/router/router.dart';
import 'package:timestampphy/ui/screens/confirm_picture/confirm_picture_screen.dart';

class TakePictureScreen extends StatefulWidget {
  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  CameraDescription camera;
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    this._initCamera();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  void _initCamera() async {
    List<CameraDescription> allCameras = await availableCameras();
    camera = allCameras.first;

    setState(() {
      _controller = CameraController(
        camera,
        ResolutionPreset.veryHigh
      );

      _initializeControllerFuture = _controller.initialize();
    });
  }

  void _takePicture() async{
    try {
      await _initializeControllerFuture;

      final path = join(
        (await getTemporaryDirectory()).path,
        '${DateTime.now()}.png',
      );

      await _controller.takePicture(path);

      Navigator.pushNamed(
          context,
          Routes.ConfirmPictureScreen,
          arguments: new ConfirmPictureScreenArgs(imagePath: path)
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: AspectRatio(
                child: CameraPreview(_controller),
                aspectRatio: _controller.value.aspectRatio,
              )
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera, color: Colors.lightBlueAccent),
        backgroundColor: Colors.white,
        onPressed: this._takePicture,
      ),
    );
  }
}