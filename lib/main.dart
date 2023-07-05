import 'package:flutter/material.dart';
import 'package:handover_app/constants.dart';
import 'package:handover_app/initializers/app.dart';
import 'package:handover_app/pages/home/home_page.dart';
import 'package:handover_app/pages/keyword/keyword_page.dart';
import 'package:handover_app/pages/setting/settings_page.dart';

main() async {
  await initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const HomePageWidget(),
    const KeywordsPageWidget(),
    const SettingsPageWidget(),
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
      debugShowCheckedModeBanner: false,
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
              icon: Icon(Icons.alarm),
              label: '키워드',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: '내 정보',
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
