import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timestampphy/core/bloc/bloc_base.dart';
import 'package:timestampphy/core/models/picture_model.dart';

const AllPicturesSubPath = '/Pictures';
const PersistedJsonName = 'persistedJson';

class PictureBloc implements BlocBase {

  final _takenPicturesSubject = BehaviorSubject<List<PictureModel>>();
  Observable<List<PictureModel>> get takenPictures => _takenPicturesSubject;

  final StreamController<String>
    _newPicturesController = StreamController<String>();
  Function(String) get addNewPicture => _newPicturesController.sink.add;

  PictureBloc() {
    _getTakenPictures();
    _newPicturesController.stream.listen(_handleNewPictures);
  }

  _handleNewPictures(String tempPicturePath) async {
    try {
      //Getting the reserved app data folder on device
      Directory deviceDirectory = await getExternalStorageDirectory();

      //Creating Pictures directory if it doesn't exist
      await new Directory('${deviceDirectory.path}/$AllPicturesSubPath').create();

      //Getting the picture from temporary folder
      File thePicture = File(tempPicturePath);

      //Copying the picture to app data folder
      String pictureFileName = DateTime.now().toIso8601String();
      String picturePath =
          '${deviceDirectory.path}/$AllPicturesSubPath/$pictureFileName.jpg';
      await thePicture.copy(picturePath);

      //Getting hash of the picture
      List<int> pictureInBytes = await thePicture.readAsBytes();
      String pictureHash = sha256.convert(pictureInBytes).toString();

      PictureModel pictureModel = new PictureModel(
          picturePath: picturePath,
          pictureHash: pictureHash,
          txHash: '0x6047c376e150c8d3cc7078133878b76ddf3dd274a619d3b645f41c43be4ace7e'
      );

      //Getting current picture List and adding the new one
      List<PictureModel> newListOfPictures = _takenPicturesSubject.value;
//      newListOfPictures.add(pictureModel);
      newListOfPictures.insert(0, pictureModel);

      //Creating json file to persist data to
      String persistedJsonPath = '${deviceDirectory.path}/$PersistedJsonName.json';
      File persistedJson = File(persistedJsonPath);

      //Writing json to the file
      String json = jsonEncode(newListOfPictures);
      persistedJson.writeAsString(json);

      _takenPicturesSubject.sink.add(newListOfPictures);
    } catch (error) {
      print(error);
      //Handle error
    }
  }

  _getTakenPictures() async {
    try {
      //Getting the reserved app data folder on device
      Directory deviceDirectory = await getExternalStorageDirectory();

      //Retrieving json
      String persistedJsonPath = '${deviceDirectory.path}/$PersistedJsonName.json';
      File persistedJson = File(persistedJsonPath);

      if(!persistedJson.existsSync()) {
        _takenPicturesSubject.sink.add(new List());
        return;
      }

      String json = await persistedJson.readAsString();
      Iterable jsonData = jsonDecode(json);

      //Mapping through data from json
      List<PictureModel> takenPictures =
        jsonData.map((item) => PictureModel.fromJson(item)).toList();

      _takenPicturesSubject.sink.add(takenPictures);

    } catch(error) {
      print(error);
      //Handle error
    }
  }

  @override
  void dispose() {
    _takenPicturesSubject.close();
    _newPicturesController.close();
  }
}