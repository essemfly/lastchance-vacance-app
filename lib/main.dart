import 'package:flutter/material.dart';
import 'package:handover_app/constants.dart';
import 'package:handover_app/initializers/app.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:handover_app/pages/home/home_page.dart';
import 'package:handover_app/pages/my/my_page.dart';
import 'package:handover_app/pages/settings/settings_page.dart';

main() async {
  timeago.setLocaleMessages('ko_KR', timeago.KoMessages());
  await initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomePageMAINWidget(),
    MyTripsWidget(),
    SettingsWidget(),
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
              label: '설정',
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
