import 'package:hitrip/data/constants.dart';

class ZamDaguuh {
  late int id;
  late String zgId;
  late String name;
  late String code;
  String? locationName;
  double? latitude;
  double? longitude;
  String? coordinate;
  String? desc;
  String? image;
  bool? hasLocation;
  String? description;

  ZamDaguuh(
      {required this.id,
      required this.zgId,
      required this.name,
      required this.code,
      this.locationName,
      this.latitude,
      this.longitude,
      this.coordinate,
      this.image,
      this.desc,
      this.hasLocation,
      this.description});

  ZamDaguuh.fromJson(Map<String, dynamic> json) {
    String defaultImg = Constants.defaultImg;

    bool locOk = json['latitude'] > 0;
    id = json['id'];
    zgId = json['zgId'];
    name = json['name'];
    code = json['id'].toString();
    locationName = json['bairshil'];
    latitude = json['latitude'].toDouble();
    longitude = json['longitude'].toDouble();
    coordinate = json['coordinate'];
    image = json['image'] == '' ? defaultImg : json['image'];
    desc = json['desc'];
    hasLocation = locOk;
    description = '--';
  }
}
