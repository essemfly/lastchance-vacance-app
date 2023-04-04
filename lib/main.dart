import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:handover_app/constants.dart';
import 'package:handover_app/initializers/app.dart';
import 'package:handover_app/pages/home/home_page.dart';
import 'package:handover_app/pages/setting/my_likes.dart';
import 'package:handover_app/pages/keyword/keyword_page.dart';

main() async {
  await initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomePageWidget(),
    KeywordsPageWidget(),
    MyLikesWidget(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '라스트 찬스 바캉스',
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.teal,
          fontFamily: Constants.fontFamily),
      home: Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '홈',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '내 정보',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: '알림',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
