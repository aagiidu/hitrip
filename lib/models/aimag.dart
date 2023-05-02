class Aimag {
  String id;
  String name;
  String details;
  List<String> uzmers;
  List<Soum> sums;

  Aimag({
    required this.id,
    required this.name,
    required this.details,
    required this.uzmers,
    required this.sums,
  });

  factory Aimag.fromJson(Map<String, dynamic> d) {
    // List<Soum> sumList = d['sums'].map((s) => Soum.fromJson(s)).toList();
    List<Soum> sumList =
        (d['sums'] as List<dynamic>).map((s) => Soum.fromJson(s)).toList();
    return Aimag(
      id: d['id'],
      name: d['name'],
      details: d['details'],
      uzmers: d['uzmers'],
      sums: sumList,
    );
  }
}

class Soum {
  Soum({
    required this.name,
    required this.location,
    required this.desc,
    required this.distance,
    required this.isExpanded,
  });

  String name;
  String location;
  String desc;
  String distance;
  bool isExpanded;

  factory Soum.fromJson(Map<String, dynamic> d) {
    return Soum(
      name: d['sum'],
      location: d['location'],
      desc: d['desc'],
      distance: d['distance'],
      isExpanded: false,
    );
  }
}
