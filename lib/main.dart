import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timestampphy/app.dart';

void main() async {
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(App());
}