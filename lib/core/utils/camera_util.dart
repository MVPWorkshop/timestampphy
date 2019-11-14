import 'package:camera/camera.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

class CameraUtil {
  CameraDescription _frontFacingCamera;

  CameraController _cameraController;
  CameraController get cameraController => _cameraController;

  Future<void> _initializeControllerFuture;
  Future<void> get isCameraInitialized => _initializeControllerFuture;

  Future<CameraDescription> _getFrontFacingCamera() async {

    List<CameraDescription> _availableCameras;

    try {
      _availableCameras = await availableCameras();

      if(_availableCameras.length > 0) {
        return _availableCameras.first;
      }

      throw("No camera found");
    } catch(error) {
      //Parse through some error handler
      return error;
    }
  }

  void _initCamera() async {
    _frontFacingCamera = await this._getFrontFacingCamera();

    if (_cameraController != null) {
      await _cameraController.dispose();
    }

    _cameraController = CameraController(
        _frontFacingCamera,
        ResolutionPreset.veryHigh
    );

    try {
      _initializeControllerFuture = _cameraController.initialize();
    } catch(error) {
      //Parse through some error handler
    }
  }

  Future<String> takePicture() async {
    try {
      final tempPicturePath = join(
        (await getTemporaryDirectory()).path,
        '${DateTime.now()}.png',
      );

      await _cameraController.takePicture(tempPicturePath);

      return tempPicturePath;

    } catch (error) {
      //Should parse and handle error
      return(error);
    }
  }

  CameraUtil() {
    this._initCamera();
  }

  void dispose() {
    _cameraController.dispose();
  }
}