import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:timestampphy/core/models/picture_model.dart';
import 'package:timestampphy/ui/widgets/picture_info.dart';

class PhotoSearchTab extends StatefulWidget {
  @override
  _PhotoSearchTabState createState() => _PhotoSearchTabState();
}

class _PhotoSearchTabState extends State<PhotoSearchTab> {
  File _selectedPicture;
  String _selectedPictureHash;
  bool _selectingPicture = false;

  void _selectPicture(context) async {
    try {
      setState(() {
        _selectingPicture = true;
      });

      File picture = await ImagePicker.pickImage(source: ImageSource.gallery);
      String pictureHash;

      if (picture.path != null) {
        List<int> pictureInBytes = await picture.readAsBytes();
        pictureHash = sha256.convert(pictureInBytes).toString();
      }

      await Future.delayed(Duration(seconds: 2));

      final snackBar = SnackBar(content: Text('Yay! We found your picture!'));
      Scaffold.of(context).showSnackBar(snackBar);

      setState(() {
        _selectedPicture = picture;
        _selectedPictureHash = pictureHash;
        _selectingPicture = false;
      });
    } catch(error) {
      setState(() {
        _selectingPicture = false;
      });
    }
  }

  dynamic _createPictureInfo() {
    if(_selectingPicture) {
      return LinearProgressIndicator();
    }

    if (_selectedPicture == null) {
      return Container();
    }

    PictureModel fakePic = new PictureModel(
        picturePath: _selectedPicture.path,
        pictureHash: _selectedPictureHash,
        txHash:
            '0x6047c376e150c8d3cc7078133878b76ddf3dd274a619d3b645f41c43be4ace7e');

    return PictureInfo(
      picture: fakePic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      children: <Widget>[
        Container(
          child: RaisedButton(
            onPressed: () => _selectPicture(context),
            child: const Text("Select a picture"),
          ),
        ),
        _createPictureInfo()
      ],
    );
  }
}
