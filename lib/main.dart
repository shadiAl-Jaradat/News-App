import 'package:flutter/material.dart';
import 'app/app.dart';
import 'app/app_bootstrap.dart';

void main() async {
  await AppBootstrap.init();
  runApp(const App());
}
