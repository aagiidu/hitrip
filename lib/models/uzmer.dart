import 'package:hitrip/data/constants.dart';

class Uzmer {
  String? code;
  String? tripCode;
  String? placeCode;
  String? name;
  String? locationName;
  String? coordinate;
  double? latitude;
  double? longitude;
  String? description;
  String? image1;
  String? image2;
  String? image3;
  bool? hasLocation;

  Uzmer({
    this.code,
    this.tripCode,
    this.placeCode,
    this.name,
    this.locationName,
    this.coordinate,
    this.latitude,
    this.longitude,
    this.description,
    this.image1,
    this.image2,
    this.image3,
    this.hasLocation,
  });

  factory Uzmer.fromJson(Map<String, dynamic> d) {
    String defaultImg = Constants.defaultImg;
    List loc = d['latlng'] != null ? d['latlng'].split(',') : [];
    double lat = 0;
    double lng = 0;
    bool locOk = true;
    if (loc.length > 1) {
      try {
        lat = double.parse(loc[0]);
        lng = double.parse(loc[1]);
      } catch (e) {
        locOk = false;
      }
    }
    return Uzmer(
      code: d['code'],
      tripCode: d['trip'],
      placeCode: d['place'],
      name: d['name'],
      locationName: d['locationName'] ?? '-- n/a --',
      coordinate: d['coordinate'],
      latitude: locOk ? lat : null,
      longitude: locOk ? lng : null,
      description: d['description'],
      image1: d['image-1'] ?? defaultImg,
      image2: d['image-2'] ?? defaultImg,
      image3: d['image-2'] ?? defaultImg,
      hasLocation: locOk,
    );
  }
}
