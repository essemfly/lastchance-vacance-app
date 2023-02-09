import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:handover_app/constants.dart';
import 'package:handover_app/pages/app/components/bottom_nav_bar.dart';
import '../index.dart';

class NavBarPage extends StatefulWidget {
  NavBarPage({Key? key, this.initialPage, this.page}) : super(key: key);

  final String? initialPage;
  final Widget? page;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

/// This is the private State class that goes with NavBarPage.
class _NavBarPageState extends State<NavBarPage> {
  String _currentPageName = 'homePage_MAIN';
  late Widget? _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPageName = widget.initialPage ?? _currentPageName;
    _currentPage = widget.page;
  }

  @override
  Widget build(BuildContext context) {
    final tabs = {
      'homePage_MAIN': HomePageMAINWidget(),
      'myTrips': MyTripsWidget(),
      'settings': SettingsWidget(),
    };

    final currentIndex = tabs.keys.toList().indexOf(_currentPageName);
    return Scaffold(
        body: _currentPage ?? tabs[_currentPageName],
        bottomNavigationBar: BottomNavBar());
  }
}
