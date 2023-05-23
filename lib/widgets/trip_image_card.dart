import 'package:flutter/material.dart';
import '../data/constants.dart';
import '../models/trip.dart';
import '../pages/trip_detail.dart';
import '../utils/next_screen.dart';
import 'custom_cache_image.dart';

class TripImageCard extends StatelessWidget {
  final TripModel d;
  final bool enabled;
  const TripImageCard({Key? key, required this.d, required this.enabled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Stack(
        children: <Widget>[
          Hero(
            tag: 'trips${d.timestamp}',
            child: Container(
                /* height: 120,*/
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: ClipRRect(
                    clipBehavior: Clip.antiAlias,
                    borderRadius: BorderRadius.circular(5),
                    child: CustomCacheImage(
                        imageUrl:
                            "${Constants.serverUrl}/photos/trip/${d.code}_1.jpg"))),
          ),
          enabled
              ? Positioned(
                  top: 3,
                  right: 3,
                  child: Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.green),
                      padding: const EdgeInsets.all(5),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 12,
                      )),
                )
              : Container(),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              // height: 40,
              decoration: BoxDecoration(
                  color: Colors.grey[900]!.withOpacity(0.6),
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    d.name!,
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.location_on,
                          size: 15, color: Colors.grey[400]),
                      Expanded(
                        child: Text(
                          d.urt!,
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey[400],
                              fontWeight: FontWeight.w500),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      onTap: () =>
          nextScreen(context, TripDetails(data: d, tag: 'trips${d.timestamp}')),
    );
  }
}
