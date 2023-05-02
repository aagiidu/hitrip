import '../data/constants.dart';

class Place {
  String? trip;
  String? code;
  String? name;
  String? locationName;
  String? location;
  double? latitude;
  double? longitude;
  String? description;
  String? zamNuhtsul;
  List images;
  String? path;
  String? remarks;

  Place({
    this.trip,
    this.code,
    this.name,
    this.locationName,
    this.location,
    this.latitude,
    this.longitude,
    this.description,
    this.zamNuhtsul,
    required this.images,
    this.path,
    this.remarks,
  });

  factory Place.fromJson(Map<String, dynamic> d) {
    List images = d['images'].length > 0
        ? d['images']
            .map((img) => "${Constants.serverUrl}/photos/$img")
            .toList()
        : [Constants.defaultImg];
    return Place(
      trip: d['state'],
      code: d['code'],
      name: d['placeName'],
      locationName: d['locationName'],
      location: d['location'],
      latitude: d['latitude'],
      longitude: d['longitude'],
      description: d['description'] ?? '',
      zamNuhtsul: d['zamNuhtsul'],
      images: images,
      path: d['path'],
      remarks: d['remarks'],
    );
  }
}
