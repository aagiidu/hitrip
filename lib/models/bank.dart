class Bank {
  String name;
  String description;
  String logo;
  String link;

  Bank({
    required this.name,
    required this.description,
    required this.logo,
    required this.link,
  });

  factory Bank.fromJson(Map<String, dynamic> d) {
    return Bank(
      name: d['name'],
      description: d['description'],
      logo: d['logo'],
      link: d['link'],
    );
  }
}
