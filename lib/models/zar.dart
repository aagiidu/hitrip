class Zar {
  String id;
  String title;
  String body;
  String name;
  String fbid;
  int featured;
  DateTime timestamp;

  Zar({
    required this.id,
    required this.title,
    required this.body,
    required this.name,
    required this.fbid,
    required this.featured,
    required this.timestamp,
  });

  factory Zar.fromJson(Map<String, dynamic> d) {
    return Zar(
      id: d['_id'],
      title: d['title'],
      body: d['body'],
      name: d['name'],
      fbid: d['fbid'],
      featured: d['featured'],
      timestamp: DateTime.parse(d['timestamp']),
    );
  }
}
