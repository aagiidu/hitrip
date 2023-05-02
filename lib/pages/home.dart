import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../services/app_services.dart';
import '../utils/snackbar.dart';
import 'explore.dart';
import 'trips.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  List<IconData> iconList = [
    Feather.home,
    Feather.list,
    Feather.grid,
    Feather.bookmark
  ];

  final List<String> _labels = ['Эхлэл', 'Аялалууд', 'Мэдээ', 'Зар'];

  void onTabTapped(int index) {
    setState(() => _currentIndex = index);
    _pageController.animateToPage(index,
        curve: Curves.easeIn, duration: const Duration(milliseconds: 300));
  }

  @override
  void initState() {
    super.initState();
    AppService().checkInternet().then((hasInternet) {
      if (hasInternet == false) {
        openSnacbar(scaffoldMessengerKey, 'no internet');
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future _onWillPop() async {
    if (_currentIndex != 0) {
      setState(() => _currentIndex = 0);
      _pageController.animateToPage(0,
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    } else {
      await SystemChannels.platform
          .invokeMethod<void>('SystemNavigator.pop', true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await _onWillPop(),
      child: Scaffold(
        key: scaffoldMessengerKey,
        bottomNavigationBar: AnimatedBottomNavigationBar.builder(
          itemCount: _labels.length,
          gapLocation: GapLocation.none,
          activeIndex: _currentIndex,
          splashColor: Theme.of(context).primaryColor,
          tabBuilder: (int index, bool isActive) {
            final color = isActive ? Colors.blue : Colors.grey;
            final title = _labels[index];
            final icon = iconList[index];
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
                Text(title, style: TextStyle(color: color, fontSize: 12)),
              ],
            );
          },
          onTap: (index) => onTabTapped(index),
        ),
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: <Widget>[
            const Explore(),
            TripsPage(),
            Container(),
            Container(),
          ],
        ),
      ),
    );
  }
}
