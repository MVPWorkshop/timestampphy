import 'package:flutter/material.dart';
import 'package:timestampphy/core/bloc/bloc_provider.dart';
import 'package:timestampphy/core/bloc/picture_bloc.dart';
import 'package:timestampphy/core/models/picture_model.dart';
import 'package:timestampphy/ui/widgets/picture_info.dart';

class PhotoHistoryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pictureBloc = BlocProvider.of<PictureBloc>(context);

    return StreamBuilder(
        stream: pictureBloc.takenPictures,
        builder: (context, AsyncSnapshot<List<PictureModel>> pictures) {
          if (!pictures.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (pictures.data.length == 0) {
            return Center(
                child: Container(
                    width: 200,
                    child: Text(
                        "You haven't taken any pictures yet, press the button in the center to start",
                        style: TextStyle(fontSize: 18, color: Colors.lightBlue),
                        textAlign: TextAlign.center)));
          }

          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 15),
            itemCount: pictures.data.length,
            itemBuilder: (context, index) {
              return PictureInfo(
                picture: pictures.data[index],
              );
            },
          );
        });
  }
}
