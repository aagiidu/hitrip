import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import '../models/place.dart';
import '../models/trip.dart';
import '../pages/gmap.dart';
import '../services/data_services.dart';
import '../utils/list_card.dart';
import '../utils/next_screen.dart';

class PlaceItems extends StatefulWidget {
  final TripModel trip;
  PlaceItems({Key? key, required this.trip}) : super(key: key);

  @override
  State<PlaceItems> createState() => _PlaceItemsState();
}

class _PlaceItemsState
    extends State<PlaceItems> /* with AutomaticKeepAliveClientMixin */ {
  DataService ds = DataService();
  List<Place> places = [];
  Map<String, List> uzmers = {};
  Map<String?, List> zamdaguuh = {};
  bool mapLoading = false;

  @override
  void initState() {
    places = ds.getPlaces(widget.trip.code);
    uzmers = ds.getUzmerMapped(widget.trip.code);
    for (var i = 0; i < places.length; i++) {
      zamdaguuh[places[i].code] = ds.getZamDaguuhByPlace(places[i].code);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final spb = context.watch<PlaceBloc>();
    return Column(
      children: <Widget>[
        Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                ),
                child: Text(
                  'Зорих газрууд',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey[800],
                      wordSpacing: 1,
                      letterSpacing: -0.6),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              child: TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.blueAccent),
                      foregroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.white)),
                  onPressed: mapLoading
                      ? null
                      : () async {
                          setState(() {
                            mapLoading = true;
                          });
                          Future.delayed(const Duration(milliseconds: 500))
                              .then((value) async {
                            var back = await nextScreen(
                                context,
                                Gmap(
                                  d: widget.trip,
                                  placeList: places,
                                ));
                            if (back != null) {
                              setState(() {
                                mapLoading = false;
                              });
                            }
                          });
                        },
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(
                          height: 20,
                          width: 20,
                          child: Icon(LineIcons.mapMarked, size: 20),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          mapLoading ? 'Ачаалж байна...' : 'GoogleMap',
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15),
                        ),
                      ])),
            )
          ],
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            padding: const EdgeInsets.only(left: 10, right: 10),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: places.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ListCard(
                    d: places[index],
                    tag: 'sp1$index',
                    color: Colors.grey[200],
                  ),
                  uzmers[places[index].code] == null
                      ? Container()
                      : const Padding(
                          padding: EdgeInsets.only(left: 5.0, top: 8.0),
                          child: Text(
                            'Зорих үзмэрүүд:',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                  ListView.builder(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: uzmers[places[index].code] == null
                        ? 1
                        : uzmers[places[index].code]?.length,
                    itemBuilder: (BuildContext context2, int index2) {
                      if (uzmers[places[index].code] == null) {
                        return Container();
                      } else {
                        return UzmerCard(
                          index: index2 + 1,
                          d: uzmers[places[index].code]![index2],
                          color: Colors.grey[100],
                        );
                      }
                    },
                  ),
                  zamdaguuh[places[index].code] == null
                      ? Container()
                      : const Padding(
                          padding: EdgeInsets.only(left: 5.0, top: 8.0),
                          child: Text(
                            'Зам дагуух үзмэрүүд:',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                  ListView.builder(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: zamdaguuh[places[index].code]?.length,
                    itemBuilder: (BuildContext context2, int index2) {
                      if (zamdaguuh[places[index].code] == null) {
                        return Container();
                      } else {
                        /// eniig solino
                        return ZamDaguuhCard(
                          index: index2 + 1,
                          d: zamdaguuh[places[index].code]![index2],
                          color: Colors.grey[100],
                        );
                        ///////////
                      }
                    },
                  ),
                ],
              );
            },
          ),
        )
      ],
    );
  }

  // @override
  // bool get wantKeepAlive => true;
}
