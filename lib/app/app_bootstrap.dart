import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/core/injection/service_locator.dart' as di;

class AppBootstrap {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    await di.init();

    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }
}
