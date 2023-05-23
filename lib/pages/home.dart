import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hitrip/pages/places.dart';
import 'package:hitrip/pages/zarlist.dart';
import 'package:line_icons/line_icons.dart';
import '../services/app_services.dart';
import '../utils/next_screen.dart';
import '../utils/snackbar.dart';
import '../widgets/header.dart';
import 'aimags.dart';
import 'blogs.dart';
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
    Icons.home,
    Icons.list,
    Icons.grid_3x3,
    Icons.bookmark
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

  Column mainContainer() {
    return Column(
      children: [
        const Header(showSearch: true),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: GridView.count(
              padding: const EdgeInsets.all(0),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              crossAxisCount: 2,
              childAspectRatio: 1.4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: <Widget>[
                InkWell(
                  child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: Colors.blueAccent[400]!,
                                        offset: const Offset(5, 5),
                                        blurRadius: 2)
                                  ]),
                              child: const Icon(
                                LineIcons.road,
                                size: 30,
                              ),
                            ),
                            const Text(
                              'Аялалууд',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                            ),
                          ])),
                  onTap: () => onTabTapped(1), // bloc-oor damjuulah!
                ),
                InkWell(
                  onTap: () => nextScreen(context, Places()),
                  child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: Colors.green[400]!,
                                        offset: const Offset(5, 5),
                                        blurRadius: 2)
                                  ]),
                              child: const Icon(
                                LineIcons.mountain,
                                size: 30,
                              ),
                            ),
                            const Text(
                              'Зорих газрууд',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                            ),
                          ])),
                ),
                InkWell(
                    onTap: null,
                    child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.orangeAccent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                          color: Colors.orangeAccent[400]!,
                                          offset: const Offset(5, 5),
                                          blurRadius: 2)
                                    ]),
                                child: const Icon(
                                  Icons.location_city,
                                  size: 30,
                                ),
                              ),
                              const Text(
                                'City Tour',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15),
                              ),
                            ])) /* () => nextScreen(
                            context,
                            RestaurantPage(
                              placeData: null,
                            )), */
                    ),
                InkWell(
                  onTap: () => nextScreen(context, AimagPage()),
                  child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.pinkAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: Colors.pinkAccent[400]!,
                                        offset: const Offset(5, 5),
                                        blurRadius: 2)
                                  ]),
                              child: const Icon(
                                Icons.bookmark_outline,
                                size: 30,
                              ),
                            ),
                            const Text(
                              'Аймаг сумдын мэдээлэл',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                            ),
                          ])),
                ),
              ],
            ),
          ),
        ),
      ],
    );
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
            mainContainer(), // const Explore(),
            TripsPage(),
            const BlogPage(),
            const ZarList(),
          ],
        ),
      ),
    );
  }
}
