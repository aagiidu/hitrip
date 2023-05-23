import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:hitrip/blocs/sign_in_block.dart';
import 'package:hitrip/pages/subscription.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import '../config/config.dart';
import '../data/constants.dart';
import '../models/place.dart';
import '../models/trip.dart';
import '../services/data_services.dart';
import '../utils/next_screen.dart';
import '../widgets/custom_cache_image.dart';
import '../widgets/place_items.dart';

class TripDetails extends StatefulWidget {
  final TripModel data;
  final String? tag;

  const TripDetails({Key? key, required this.data, required this.tag})
      : super(key: key);

  @override
  _TripDetailsState createState() => _TripDetailsState();
}

class _TripDetailsState extends State<TripDetails> {
  final String collectionName = 'states';
  List<Place> places = [];
  DataService ds = DataService();
  late TripModel trip;
  @override
  void initState() {
    trip = widget.data;
    // places = ds.getPlaces(trip.code);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SignInBloc sb = context.read<SignInBloc>();
    bool enabled = sb.isEnabled(trip.code);
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
                        tag: widget.tag!,
                        child: _slidableImages(),
                      ),
                Positioned(
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
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(trip.name!,
                      style: TextStyle(
                          fontSize: 17,
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
                  tripBrief(),
                  const Text(
                    'Санал болгох шалтгаан: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(trip.desc!),
                ],
              ),
            ),
            !enabled
                ? Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    alignment: Alignment.center,
                    color: Colors.green[300],
                    child: Column(
                      children: [
                        const Text(
                            'Дэлгэрэнгүй үзэхийн тулд эрхээ идэвхижүүлнэ үү'),
                        const SizedBox(height: 8),
                        const Text("₮9'800"),
                        TextButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.symmetric(horizontal: 20)),
                            backgroundColor: MaterialStateProperty.resolveWith(
                                (states) => Colors.green),
                          ),
                          onPressed: () => nextScreenPopup(
                              context,
                              Subsciption(
                                selectedTrip: trip,
                              )),
                          child: const Text(
                            'Идэвхижүүлэх',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Text(
                                  'Үндсэн маршрут: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(trip.marshrut!),
                              ])),
                      PlaceItems(trip: trip),
                    ],
                  ),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }

  Column tripBrief() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Зорих чиглэл: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            Expanded(
                child: Text(
              trip.chiglel!,
              style: TextStyle(fontSize: 15, color: Config.txtColor),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Хугацаа: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            Expanded(
                child: Text(
              trip.honog!,
              style: TextStyle(fontSize: 15, color: Config.txtColor),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Нийт зам: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            Expanded(
                child: Text(
              trip.urt!,
              style: TextStyle(fontSize: 15, color: Config.txtColor),
              maxLines: 2,
            )),
          ],
        ),
      ],
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
          images: [1, 2, 3]
              .map((i) => CustomCacheImage(
                  imageUrl:
                      "${Constants.serverUrl}/photos/trip/${trip.code}_$i.jpg"))
              .toList(),
        ),
      ),
    );
  }
}
