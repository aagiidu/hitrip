import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../config/config.dart';
import '../data/data_selector.dart';
import '../models/place.dart';
import '../models/trip.dart';
import '../models/zorih_uzmer.dart';
import '../services/data_services.dart';
import '../utils/convert_map_icon.dart';
import 'place_detail.dart';
import 'uzmer_detail.dart';

enum SelectedType { UZMER, PLACE, NONE }

class Gmap extends StatefulWidget {
  final TripModel? d;
  final List<Place>? placeList;

  const Gmap({Key? key, required this.d, this.placeList}) : super(key: key);

  _GmapState createState() => _GmapState();
}

class _GmapState extends State<Gmap> {
  late GoogleMapController mapController;
  DataService ds = DataService();
  late TripModel trip;
  List<Marker> _markers = [];
  Map? data = {};
  String distance = 'O км';

  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  late Position myPosition;

  late Uint8List _sourceIcon;
  late Uint8List _placeIcon;
  late Uint8List _uzmerIcon;

  // final FileStorage _fileStorage = FileStorage();

  List<LatLng> pathPoints = [];
  List<Place> places = [];
  List<ZorihUzmer> zorihUzmers = [];
  late Place selectedPlace;
  late ZorihUzmer selectedUzmer;
  SelectedType selectedType = SelectedType.NONE;
  Map path = {};

  @override
  void initState() {
    super.initState();
    trip = widget.d!;
    _getMyPosition();
    //_setMarkerIcons();
    path = DataSelector().getPath(trip.code);
    _getPolyline();
  }

  @override
  void dispose() {
    super.dispose();
    _markers = [];
    mapController.dispose();
    polylineCoordinates = [];
    places = [];
    zorihUzmers = [];
    path = {};
  }

  Future _getMyPosition() async {
    final status = await Permission.locationWhenInUse.status;
    if (!status.isGranted) {
      if (await Permission.locationWhenInUse.request().isGranted) {
        Position pos = await Geolocator.getCurrentPosition();
        print('################# Myposition');
        print('${pos.latitude}, ${pos.longitude}');
        setState(() {
          _markers.add(Marker(
            markerId: const MarkerId('myposition'),
            position: LatLng(pos.latitude, pos.longitude),
          ));
        });
        // mapController.setMyLocationEnabled(true);
      }
    }
  }

  Future _setMarkerIcons() async {
    _sourceIcon = await getBytesFromAsset(Config().drivingMarkerIcon, 40);
    _uzmerIcon = await getBytesFromAsset(Config().uzmerPinIcon, 40);
    _placeIcon = await getBytesFromAsset(Config().placePinIcon, 80);
  }

  Future _getMarkerData() async {
    places = widget.placeList!;
    zorihUzmers = ds.getUzmerByTrip(trip.code);
    setMarkers();
  }

  Future setMarkers() async {
    List m = [];

    for (var i = 0; i < places.length; i++) {
      m.add(Marker(
        markerId: MarkerId('place${places[i].code!}'),
        position: LatLng(places[i].latitude != null ? places[i].latitude! : 0,
            places[i].longitude != null ? places[i].longitude! : 0),
        infoWindow: InfoWindow(title: places[i].name),
        icon: BitmapDescriptor.fromBytes(_placeIcon),
        onTap: () {
          setState(() {
            selectedType = SelectedType.PLACE;
            selectedPlace = places[i];
          });
        },
      ));
    }

    for (var i = 0; i < zorihUzmers.length; i++) {
      m.add(Marker(
        markerId: MarkerId('uzmer${zorihUzmers[i].code!}'),
        position: LatLng(
            zorihUzmers[i].latitude != null ? zorihUzmers[i].latitude! : 0,
            zorihUzmers[i].longitude != null ? zorihUzmers[i].longitude! : 0),
        infoWindow: InfoWindow(title: zorihUzmers[i].name),
        icon: BitmapDescriptor.fromBytes(_uzmerIcon),
        onTap: () {
          setState(() {
            selectedType = SelectedType.UZMER;
            selectedUzmer = zorihUzmers[i];
          });
        },
      ));
    }

    setState(() {
      m.forEach((element) {
        _markers.add(element);
      });
    });
  }

  Future _getPolyline() async {
    Map<PolylineId, Polyline> temp = {};
    List p = path["data"];
    for (var i = 0; i < p.length; i++) {
      PolylineId id = PolylineId("poly$i");
      /* Polyline polyline = Polyline(
          polylineId: id,
          color: p[i]["roadType"] == 'dirtroad'
              ? Colors.black54
              : Color.fromARGB(255, 40, 122, 198),
          patterns: [PatternItem.dash(10), PatternItem.gap(3)],
          points: p[i]["path"],
          width: 4);
      temp[id] = polyline; */
      if (p[i]["roadType"] == 'dirtroad') {
        Polyline polyline = Polyline(
            polylineId: id,
            color: Colors.black,
            patterns: [PatternItem.dash(10), PatternItem.gap(3)],
            points: p[i]["path"],
            width: 3);
        temp[id] = polyline;
      } else {
        Polyline polyline = Polyline(
            polylineId: id,
            color: const Color.fromARGB(255, 40, 122, 198),
            patterns: [PatternItem.dash(10), PatternItem.gap(3)],
            points: p[i]["path"],
            width: 4);
        temp[id] = polyline;
      }
    }
    setState(() {
      polylines = temp;
    });
  }

  void animateCamera() {
    LatLngBounds bounds;
    Map bnd = path["bounds"];
    LatLng southwest = bnd["southwest"];
    LatLng northeast = bnd["northeast"];
    bounds = LatLngBounds(southwest: southwest, northeast: northeast);
    mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 30));
  }

  Future<void> onMapCreated(controller) async {
    //controller.setMapStyle(MapUtils.mapStyles);
    setState(() {
      mapController = controller;
    });
    await _setMarkerIcons();
    animateCamera();
    _getMarkerData();
  }

  Widget panelUI() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 30,
              height: 5,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: const BorderRadius.all(Radius.circular(12.0))),
            ),
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              selectedType == SelectedType.PLACE
                  ? selectedPlace.name!
                  : selectedUzmer.name!,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 8, bottom: 8),
          height: 3,
          width: 170,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(40)),
        ),
        Expanded(
            child: selectedType == SelectedType.PLACE
                ? PlaceDetails(
                    data: selectedPlace,
                    tag: selectedPlace.code,
                    isPanel: true,
                    isShort: true,
                  )
                : UzmerDetails(
                    data: selectedUzmer,
                    tag: selectedUzmer.code!,
                    isPanel: true,
                  )),
      ],
    );
  }

  Widget panelBodyUI(h, w) {
    return SizedBox(
      width: w,
      child: GoogleMap(
        zoomControlsEnabled: true,
        initialCameraPosition: Config.initialCameraPosition,
        mapType: MapType.normal,
        onMapCreated: (controller) async {
          await onMapCreated(controller);
        },
        markers: Set.from(_markers),
        polylines: Set<Polyline>.of(polylines.values),
        compassEnabled: false,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomGesturesEnabled: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SafeArea(
      child: Stack(children: <Widget>[
        SlidingUpPanel(
            minHeight: selectedType != SelectedType.NONE ? 200 : 0,
            maxHeight: MediaQuery.of(context).size.height * 0.80,
            backdropEnabled: true,
            backdropOpacity: 0.2,
            backdropTapClosesPanel: true,
            isDraggable: true,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey[400]!,
                  blurRadius: 4,
                  offset: const Offset(1, 0))
            ],
            padding:
                const EdgeInsets.only(top: 15, left: 10, bottom: 0, right: 10),
            panel: selectedType != SelectedType.NONE ? panelUI() : Container(),
            body: panelBodyUI(h, w)),
        Positioned(
          top: 15,
          left: 10,
          child: Container(
            child: Row(
              children: <Widget>[
                InkWell(
                  child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.grey[300]!,
                              blurRadius: 10,
                              offset: const Offset(3, 3))
                        ]),
                    child: const Icon(Icons.keyboard_backspace),
                  ),
                  onTap: () {
                    Navigator.pop(context, 'back from map');
                  },
                ),
                const SizedBox(
                  width: 5,
                ),
                data!.isEmpty
                    ? Container()
                    : Container(
                        width: MediaQuery.of(context).size.width * 0.80,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.grey, width: 0.5)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 15, top: 10, bottom: 10, right: 15),
                          child: Text(
                            '${widget.d!.name}',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ]),
    ));
  }
}
