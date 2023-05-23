import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../data/constants.dart';

class Blog {
  String id;
  String title;
  String description;
  String? image;
  String date;

  Blog(
      {required this.id,
      required this.title,
      required this.description,
      this.image,
      required this.date});

  factory Blog.fromJson(Map<String, dynamic> d) {
    String image = d['image'] ?? Constants.defaultImg;
    return Blog(
      id: d['_id'],
      title: d['title'],
      description: d['description'],
      image: image,
      date: DateFormat('yyyy-MM-dd HH:mm:ss')
          .format(DateTime.parse(d['timestamp'])),
    );
  }
}
