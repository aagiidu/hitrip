import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import '../models/trip.dart';
import '../pages/trip_detail.dart';
import '../utils/next_screen.dart';
import 'custom_cache_image.dart';

class TripCard extends StatelessWidget {
  final TripModel? d;
  final String tag;
  final Color? color;

  const TripCard({Key? key, required this.d, required this.tag, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: <Widget>[
                Container(
                  height: 120,
                  margin: const EdgeInsets.only(top: 15),
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: const EdgeInsets.only(
                        top: 15, left: 25, right: 10, bottom: 0),
                    /* alignment: Alignment.topLeft, */
                    height: 90,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 115, right: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            d!.name!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 8, bottom: 8),
                            height: 2,
                            width: 120,
                            decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Feather.map_pin,
                                size: 12,
                                color: Colors.grey,
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Expanded(
                                child: Text(
                                  d!.name!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[700]),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              bottom: 0,
              left: 5,
              child: Hero(
                tag: tag,
                child: SizedBox(
                    height: 120,
                    width: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: CustomCacheImage(imageUrl: d!.thumbnailUrl))),
              ))
        ],
      ),
      onTap: () => nextScreen(
          context,
          TripDetails(
            data: d!,
            tag: tag,
          )),
    );
  }
}
