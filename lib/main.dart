import 'package:flutter/material.dart';
import 'package:handover_app/constants.dart';
import 'package:handover_app/initializers/app.dart';
import 'package:handover_app/pages/home/home_page.dart';
import 'package:handover_app/pages/my/my_page.dart';
import 'package:handover_app/pages/settings/settings_page.dart';

void main() {
  initliazeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '라스트 찬스 바캉스',
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            primarySwatch: Colors.teal,
            fontFamily: Constants.fontFamily),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePageMAINWidget(),
          '/myinfo': (context) => const MyTripsWidget(),
          '/settings': (context) => const SettingsWidget(),
        });
  }
}
