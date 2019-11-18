import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timestampphy/core/models/picture_model.dart';

class PictureInfo extends StatelessWidget {
  final PictureModel picture;

  PictureInfo({this.picture});

  @override
  Widget build(BuildContext context) {
    const labelTextStyle = TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.lightBlue);

    const textValue = TextStyle(fontSize: 14);

    return Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Container(
            padding: EdgeInsets.all(15),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 100),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.file(File(picture.picturePath))),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Time", style: labelTextStyle),
                          SelectableText(
                              DateFormat('MMM dd yyyy, HH:m').format(picture.date),
                              style: textValue
                          ),
                          SizedBox(height: 15),
                          Text("Transaction hash", style: labelTextStyle),
                          SelectableText(picture.txHash, style: textValue)
                        ],
                      ),
                    ),
                  )
                ])));
  }
}
