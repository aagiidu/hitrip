import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../data/constants.dart';
import '../models/place.dart';
import '../models/zam_daguuh.dart';
import '../models/zorih_uzmer.dart';
import '../pages/place_detail.dart';
import '../pages/uzmer_detail.dart';
import '../widgets/custom_cache_image.dart';
import 'next_screen.dart';

class ListCard extends StatelessWidget {
  final Place? d;
  final String tag;
  final Color? color;

  const ListCard(
      {Key? key, required this.d, required this.tag, required this.color})
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
                                Icons.pin,
                                size: 12,
                                color: Colors.grey,
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Expanded(
                                child: Text(
                                  d!.locationName!,
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
                        child: CustomCacheImage(imageUrl: d!.images[0]))),
              ))
        ],
      ),
      onTap: () => nextScreen(
          context,
          PlaceDetails(
            data: d!,
            tag: tag,
            isPanel: false,
          )),
    );
  }
}

class ListCard1 extends StatelessWidget {
  final Place d;
  final String? tag;
  const ListCard1({Key? key, required this.d, this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.bottomRight,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            //color: Colors.grey[200],
            child: Stack(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(
                      top: 5, left: 30, right: 10, bottom: 5),
                  alignment: Alignment.topLeft,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 110, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          d.name!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.pin,
                              size: 12,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Expanded(
                              child: Text(
                                d.location!,
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
                        Container(
                          margin: const EdgeInsets.only(top: 8, bottom: 20),
                          height: 2,
                          width: 120,
                          decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            const Icon(
                              LineIcons.heart,
                              size: 18,
                              color: Colors.orangeAccent,
                            ),
                            Text(
                              /* d.loves.toString() */ '0',
                              style: TextStyle(
                                  fontSize: 13, color: Colors.grey[600]),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Icon(
                              LineIcons.commentAlt,
                              size: 18,
                              color: Colors.grey[700],
                            ),
                            Text(
                              /* d.commentsCount.toString() */ '0',
                              style: TextStyle(
                                  fontSize: 13, color: Colors.grey[600]),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.031,
              left: 10,
              child: Hero(
                tag: tag!,
                child: SizedBox(
                    height: 120,
                    width: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: CustomCacheImage(imageUrl: d.images[0]))),
              ))
        ],
      ),
      onTap: () => nextScreen(context, PlaceDetails(data: d, tag: tag)),
    );
  }
}

class UzmerCard extends StatelessWidget {
  final int index;
  final ZorihUzmer? d;
  final Color? color;
  const UzmerCard(
      {Key? key, required this.index, required this.d, required this.color})
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
                  height: 80,
                  margin: const EdgeInsets.only(top: 8),
                  alignment: Alignment.topCenter,
                  /* padding: EdgeInsets.only(left: 50), */
                  child: Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          index.toString(),
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Container(
                          height: 80,
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 16, right: 115),
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
                                  margin:
                                      const EdgeInsets.only(top: 6, bottom: 6),
                                  height: 1,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      color: Colors.blueAccent,
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.pin,
                                      size: 12,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    Expanded(
                                      child: Text(
                                        d!.locationName!,
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
              ],
            ),
          ),
          Positioned(
              bottom: 0,
              right: 0,
              child: Hero(
                  tag: d!.code!,
                  child: SizedBox(
                    height: 80,
                    width: 80,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: CustomCacheImage(
                            imageUrl: d!.images!.length > 0
                                ? "${Constants.serverUrl}/photos/${d!.images![0]}"
                                : Constants.defaultImg)), // END!
                  )))
        ],
      ),
      onTap: () => nextScreen(
          context,
          UzmerDetails(
            data: d,
            tag: d!.code!,
            isPanel: false,
          )),
    );
  }
}

class ZamDaguuhCard extends StatelessWidget {
  final int index;
  final ZamDaguuh? d;
  final Color? color;
  const ZamDaguuhCard(
      {Key? key, required this.index, required this.d, required this.color})
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
                  height: 80,
                  margin: const EdgeInsets.only(top: 8),
                  alignment: Alignment.topCenter,
                  /* padding: EdgeInsets.only(left: 50), */
                  child: Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          index.toString(),
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Container(
                          height: 80,
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 16, right: 115),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  d!.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.only(top: 6, bottom: 6),
                                  height: 1,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      color: Colors.blueAccent,
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.pin,
                                      size: 12,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    Expanded(
                                      child: Text(
                                        d!.locationName!,
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
              ],
            ),
          ),
          Positioned(
              bottom: 0,
              right: 0,
              child: Hero(
                tag: d!.id,
                child: SizedBox(
                    height: 80,
                    width: 80,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: CustomCacheImage(imageUrl: d!.image))),
              ))
        ],
      ),
      onTap: () => nextScreen(
          context,
          UzmerDetails(
            data: d,
            tag: d!.id.toString(),
            isPanel: false,
          )),
    );
  }
}
