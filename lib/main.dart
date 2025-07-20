import 'dart:io';
import 'package:flutter/material.dart';
import 'package:news_app/core/utils/my_http_overrides.dart';
import 'app/app.dart';
import 'app/app_bootstrap.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  await AppBootstrap.init();
  runApp(const App());
}
