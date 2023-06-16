import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:hitrip/models/zam_daguuh.dart';
import 'package:line_icons/line_icons.dart';
import '../data/constants.dart';
import '../models/zorih_uzmer.dart';
import '../utils/next_screen.dart';
import '../widgets/custom_cache_image.dart';

class UzmerDetails extends StatefulWidget {
  final dynamic data;
  final String? tag;
  final bool? isPanel;
  final String? dType;

  const UzmerDetails(
      {Key? key,
      required this.data,
      required this.tag,
      this.isPanel,
      this.dType})
      : super(key: key);

  @override
  _UzmerDetailsState createState() => _UzmerDetailsState();
}

class _UzmerDetailsState extends State<UzmerDetails> {
  dynamic data;

  @override
  void initState() {
    data = widget.dType == 'ZorihUzmer'
        ? widget.data as ZorihUzmer
        : widget.data as ZamDaguuh;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final SignInBloc sb = context.watch<SignInBloc>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                widget.tag == null
                    ? _slidableImages()
                    : Hero(
                        tag: data.code,
                        child: _slidableImages(),
                      ),
                widget.isPanel == false
                    ? Positioned(
                        top: 20,
                        left: 15,
                        child: SafeArea(
                          child: CircleAvatar(
                            backgroundColor:
                                Theme.of(context).primaryColor.withOpacity(0.9),
                            child: IconButton(
                              icon: const Icon(
                                LineIcons.arrowLeft,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                      )
                    : Container(),
                data.hasLocation! && widget.isPanel == false
                    ? Positioned(
                        bottom: 5,
                        right: 5,
                        child: InkWell(
                          onTap:
                              null /* () => nextScreen(
                              context,
                              LocationPage(
                                  name: widget.data!.name!,
                                  lat: widget.data!.latitude!,
                                  lng: widget.data!.longitude!)) */
                          ,
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const <Widget>[
                                    SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: Icon(LineIcons.mapMarked,
                                          size: 20, color: Colors.white),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Google map',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15),
                                    ),
                                  ])),
                        ),
                      )
                    : Container()
              ],
            ),
            widget.isPanel == false
                ? Padding(
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 0, left: 16, right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(data.name!,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                letterSpacing: -0.6,
                                wordSpacing: 1,
                                color: Colors.grey[800])),
                        Container(
                          margin: const EdgeInsets.only(top: 8, bottom: 8),
                          height: 3,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(40)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            const Icon(
                              Icons.location_on,
                              size: 20,
                              color: Colors.grey,
                            ),
                            Expanded(
                                child: Text(
                              widget.data!.locationName!,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[600],
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )),
                          ],
                        ),
                      ],
                    ),
                  )
                : Container(),
            data.hasLocation!
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextButton(
                      onPressed: /* () => widget.isPanel == false
                          ? nextScreen(
                              context,
                              LocationPage(
                                  name: widget.data!.name!,
                                  lat: widget.data!.latitude!,
                                  lng: widget.data!.longitude!))
                          : */
                          null,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(
                              height: 20,
                              width: 20,
                              child: Icon(LineIcons.mapMarked, size: 20),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              data.coordinate!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 15),
                            ),
                          ]),
                    ),
                  )
                : Container(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(data
                  .description!), /* HtmlBodyWidget(
                content: widget.data!.description!,
                isIframeVideoEnabled: true,
                isVideoEnabled: true,
                isimageEnabled: true,
                fontSize: 15,
              ), */
            ),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }

  Container _slidableImages() {
    List<Widget> images = (data.images as List)
        .map((img) =>
            CustomCacheImage(imageUrl: "${Constants.serverUrl}/photos/$img"))
        .toList();
    return Container(
      color: Colors.white,
      child: Container(
        height: 320,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Carousel(
          dotBgColor: Colors.transparent,
          showIndicator: true,
          dotSize: 5,
          dotSpacing: 15,
          boxFit: BoxFit.cover,
          images: images,
        ),
      ),
    );
  }
}

/* images: [
  CustomCacheImage(imageUrl: widget.data!.image1),
  CustomCacheImage(imageUrl: widget.data!.image2),
  CustomCacheImage(imageUrl: widget.data!.image3),
]) */
