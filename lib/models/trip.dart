class TripModel {
  String? name;
  String? thumbnailUrl;
  String code;
  String? chiglel;
  String? honog;
  String? urt;
  String? desc;
  String? marshrut;
  String? timestamp;

  TripModel(
      {this.name,
      this.thumbnailUrl,
      required this.code,
      this.chiglel,
      this.honog,
      this.urt,
      this.desc,
      this.marshrut,
      this.timestamp});

  factory TripModel.fromJson(Map<String, dynamic> d) {
    return TripModel(
      name: d['name'],
      thumbnailUrl: d['thumbnail'],
      code: d['code'],
      chiglel: d['chiglel'],
      honog: d['honog'],
      urt: d['urt'],
      desc: d['desc'],
      marshrut: d['marshrut'],
      timestamp: d['timestamp'],
    );
  }
}
