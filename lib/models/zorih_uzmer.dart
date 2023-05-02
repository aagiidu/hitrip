class ZorihUzmer {
  String? code;
  String? tripCode;
  String? placeCode;
  String? name;
  String? locationName;
  String? coordinate;
  double? latitude;
  double? longitude;
  String? description;
  List? images;

  bool? hasLocation;

  ZorihUzmer({
    this.code,
    this.tripCode,
    this.placeCode,
    this.name,
    this.locationName,
    this.coordinate,
    this.latitude,
    this.longitude,
    this.description,
    this.images,
    this.hasLocation,
  });

  factory ZorihUzmer.fromJson(Map<String, dynamic> d) {
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
    return ZorihUzmer(
      code: d['code'],
      tripCode: d['trip'],
      placeCode: d['place'],
      name: d['name'],
      locationName: d['locationName'] ?? '-- n/a --',
      coordinate: d['coordinate'],
      latitude: locOk ? lat : null,
      longitude: locOk ? lng : null,
      description: d['description'],
      images: d['images'] ?? [],
      hasLocation: locOk,
    );
  }
}
