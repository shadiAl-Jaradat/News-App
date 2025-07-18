import 'package:flutter/material.dart';
import 'package:news_app/app/app_config.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: false,
      home: const Scaffold(body: Center(child: Text('News App - Ready for Development!'))),
    );
  }
}
