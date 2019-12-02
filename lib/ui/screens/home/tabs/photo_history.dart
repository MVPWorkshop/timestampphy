import 'package:flutter/material.dart';
import 'package:timestampphy/core/bloc/bloc_provider.dart';
import 'package:timestampphy/core/bloc/picture_bloc.dart';
import 'package:timestampphy/core/constants/images.dart';
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
                    width: 225,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Image(image: Images.emptyState, fit: BoxFit.contain),
                        SizedBox(height: 15),
                        Text(
                          "It's empty in here",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'roboto/medium',
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "You haven't taken any pictures yet. Press button in the center to start!",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFF748091)),
                        )
                      ],
                    )));
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
