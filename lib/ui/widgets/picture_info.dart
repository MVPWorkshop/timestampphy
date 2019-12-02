import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timestampphy/core/models/picture_model.dart';

class PictureInfo extends StatelessWidget {
  final PictureModel picture;

  PictureInfo({this.picture});

  @override
  Widget build(BuildContext context) {
    const dateTextStyle = TextStyle(fontSize: 12);
    const labelTextStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.bold);
    const txHashTextStyle =
        TextStyle(fontSize: 14, color: Color(0xFF748091091));

    return Card(
        margin: EdgeInsets.symmetric(vertical: 10),
        elevation: 5,
        child: Container(
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
              Container(
                width: 150,
                height: 200,
                child: Image.file(File(picture.picturePath), fit: BoxFit.cover),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SelectableText(
                          DateFormat('dd MMM yyyy, HH:mm').format(picture.date),
                          style: dateTextStyle),
                      Divider(),
                      Text("Transaction hash", style: labelTextStyle),
                      SizedBox(height: 15),
                      SelectableText(picture.txHash, style: txHashTextStyle)
                    ],
                  ),
                ),
              )
            ])));
  }
}
