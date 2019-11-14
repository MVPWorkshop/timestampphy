import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:timestampphy/core/utils/camera_util.dart';
import 'package:timestampphy/router/router.dart';
import 'package:timestampphy/ui/screens/confirm_picture/confirm_picture_screen.dart';

class TakePictureScreen extends StatefulWidget {
  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  CameraUtil cameraUtil;

  @override
  void initState() {
    super.initState();
    this._initCamera();
  }

  @override
  void dispose() {
    cameraUtil.dispose();
    super.dispose();
  }

  void _initCamera() async {
    cameraUtil = new CameraUtil();
    await cameraUtil.isCameraInitialized;

    if(!mounted) {
      return;
    }

    setState(() {});
  }

  void _takePicture() async{
    String tempPicturePath = await cameraUtil.takePicture();

    Navigator.pushNamed(
        context,
        Routes.ConfirmPictureScreen,
        arguments: new ConfirmPictureScreenArgs(picturePath: tempPicturePath)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: cameraUtil.isCameraInitialized,
        builder: this._buildCameraPreview,
      ),
      backgroundColor: Colors.black,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera, color: Colors.lightBlueAccent),
        backgroundColor: Colors.white,
        onPressed: this._takePicture,
      ),
    );
  }

  Widget _buildCameraPreview(context, snapshot) {
    var cameraController = cameraUtil.cameraController;

    if (snapshot.connectionState == ConnectionState.done) {
      return Center(
          child: AspectRatio(
            child: CameraPreview(cameraController),
            aspectRatio: cameraController.value.aspectRatio,
          )
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}