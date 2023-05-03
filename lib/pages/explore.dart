import 'package:flutter/material.dart';
import '../widgets/featured_icons.dart';
import '../widgets/header.dart';

class Explore extends StatefulWidget {
  const Explore({Key? key}) : super(key: key);

  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: const <Widget>[
            Header(),
            FeaturedIcons(),
            // Featured(),
            // PopularPlaces(),
            // SpecialStateOne(),
            // SpecialStateTwo(),
            // RecommendedPlaces()
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
