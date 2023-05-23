import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../pages/aimags.dart';
import '../pages/places.dart';
import '../pages/trips.dart';
import '../utils/next_screen.dart';

class FeaturedIcons extends StatelessWidget {
  const FeaturedIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
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
                  onTap: () =>
                      nextScreen(context, TripsPage()), // bloc-oor damjuulah!
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
          )
        ],
      ),
    );
  }
}
