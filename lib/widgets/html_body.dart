/* import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../services/app_services.dart';

// final String demoText = "<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s</p>" +
// '''<iframe width="560" height="315" src="https://www.youtube.com/embed/-WRzl9L4z3g" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'''+
// //'''<video controls src="https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4"></video>''' +
// //'''<iframe src="https://player.vimeo.com/video/226053498?h=a1599a8ee9" width="640" height="360" frameborder="0" allow="autoplay; fullscreen; picture-in-picture" allowfullscreen></iframe>''' +
// "<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s</p>";

class HtmlBodyWidget extends StatelessWidget {
  final String content;
  final bool isVideoEnabled;
  final bool isimageEnabled;
  final bool isIframeVideoEnabled;
  final double? fontSize;

  const HtmlBodyWidget({
    Key? key,
    required this.content,
    required this.isVideoEnabled,
    required this.isimageEnabled,
    required this.isIframeVideoEnabled,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Html(
      data: '''$content''',
      defaultTextStyle: TextStyle(
          fontSize: fontSize ?? 14,
          fontFamily: 'Open Sans',
          fontWeight: FontWeight.w400,
          color: Colors.blueGrey[600]),
    );
  }
}
 */