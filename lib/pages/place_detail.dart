import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import '../models/place.dart';
import '../models/trip.dart';
import '../services/data_services.dart';
import '../utils/next_screen.dart';
import '../widgets/custom_cache_image.dart';
import '../widgets/trip_card.dart';

class PlaceDetails extends StatefulWidget {
  final Place data;
  final String? tag;
  final bool? isPanel;
  final bool isShort;

  const PlaceDetails(
      {Key? key,
      required this.data,
      required this.tag,
      this.isPanel,
      this.isShort = false})
      : super(key: key);

  @override
  _PlaceDetailsState createState() => _PlaceDetailsState();
}

class _PlaceDetailsState extends State<PlaceDetails> {
  List<TripModel> relatedTrips = [];
  DataService ds = DataService();

  @override
  void initState() {
    super.initState();
    relatedTrips = ds.getRelatedTrips(widget.data.name!);
    print('isPanel: ${widget.isPanel}');
  }

  @override
  Widget build(BuildContext context) {
    // final SignInBloc sb = context.watch<SignInBloc>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                widget.tag == null
                    ? _slidableImages()
                    : Hero(
                        tag: widget.data.code!,
                        child: _slidableImages(),
                      ),
                widget.isPanel == false
                    ? Positioned(
                        top: 20,
                        left: 15,
                        child: SafeArea(
                          child: CircleAvatar(
                            backgroundColor:
                                Theme.of(context).primaryColor.withOpacity(0.9),
                            child: IconButton(
                              icon: const Icon(
                                LineIcons.arrowLeft,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                      )
                    : Container(),
                widget.isPanel == false
                    ? Positioned(
                        bottom: 5,
                        right: 5,
                        child: InkWell(
                          onTap:
                              null /* () => nextScreen(
                              context,
                              LocationPage(
                                  name: widget.data.name!,
                                  lat: widget.data.latitude!,
                                  lng: widget.data.longitude!)) */
                          ,
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const <Widget>[
                                    SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: Icon(LineIcons.mapMarked,
                                          size: 20, color: Colors.white),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Google map',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15),
                                    ),
                                  ])),
                        ),
                      )
                    : Container()
              ],
            ),
            widget.isPanel == false
                ? Padding(
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 8, left: 16, right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(widget.data.name!,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                letterSpacing: -0.6,
                                wordSpacing: 1,
                                color: Colors.grey[800])),
                        Container(
                          margin: const EdgeInsets.only(top: 8, bottom: 8),
                          height: 3,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(40)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            const Icon(
                              Icons.location_on,
                              size: 20,
                              color: Colors.grey,
                            ),
                            Expanded(
                                child: Text(
                              widget.data.locationName!,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[600],
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )),
                          ],
                        ),
                      ],
                    ),
                  )
                : Container(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextButton(
                onPressed: /*  () => widget.isPanel == false
                    ? nextScreen(
                        context,
                        LocationPage(
                            name: widget.data.name!,
                            lat: widget.data.latitude!,
                            lng: widget.data.longitude!))
                    : */
                    null,
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
                        widget.data.location!,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                    ]),
              ),
            ),
            !widget.isShort
                ? const Padding(
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Text(
                      'Чиглэл',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                    ),
                  )
                : Container(),
            !widget.isShort
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(widget.data.path!),
                  )
                : Container(),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                'Замын нөхцөл',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(widget.data.zamNuhtsul!),
            ),
            const SizedBox(height: 20),
            Container(
              color: Colors.blueAccent, //Color(0XFF2596be),
              padding: const EdgeInsets.all(16),
              child: const Text(
                'Та энэ газрыг дараах аялалуудаар бас үзэх боломжтой',
                style: TextStyle(color: Colors.white),
              ),
            ),
            //relatedTrips.map((e) => TripCard(d: e, tag: e.code)).toList()
            ListView.separated(
              padding: const EdgeInsets.all(15),
              //controller: controller,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: relatedTrips.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(
                height: 10,
              ),
              shrinkWrap: true,
              itemBuilder: (_, int index) {
                return TripCard(
                  d: relatedTrips[index],
                  tag: relatedTrips[index].code,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Container _slidableImages() {
    return Container(
      color: Colors.white,
      child: Container(
        height: 320,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Carousel(
            dotBgColor: Colors.transparent,
            showIndicator: true,
            dotSize: 5,
            dotSpacing: 15,
            boxFit: BoxFit.cover,
            images: widget.data.images
                .map((img) => CustomCacheImage(imageUrl: img))
                .toList()),
      ),
    );
  }
}
