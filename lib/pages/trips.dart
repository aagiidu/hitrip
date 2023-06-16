import 'package:flutter/material.dart';
import 'package:hitrip/blocs/sign_in_block.dart';
import 'package:provider/provider.dart';
import '../models/trip.dart';
import '../services/data_services.dart';
import '../widgets/header.dart';
import '../widgets/trip_image_card.dart';

class TripsPage extends StatefulWidget {
  final bool showBack;
  TripsPage({Key? key, this.showBack = false}) : super(key: key);

  @override
  _TripsPageState createState() => _TripsPageState();
}

class _TripsPageState extends State<TripsPage>
    with AutomaticKeepAliveClientMixin {
  ScrollController? controller;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<TripModel> trips = [];
  DataService ds = DataService();

  @override
  void initState() {
    trips = ds.tripList();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    SignInBloc sb = context.read<SignInBloc>();
    Map<String, bool> enabled = sb.enabledTrips;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Header(showSearch: false),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: trips.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.7),
                itemBuilder: (BuildContext context, int index) {
                  return TripImageCard(
                    d: trips[index],
                    enabled:
                        true /* (enabled[trips[index].code] != null &&
                            enabled[trips[index].code] == true) ||
                        enabled['all'] == true */
                    ,
                  );
                },
              ), /* ListView.separated(
                padding: const EdgeInsets.all(15),
                controller: controller,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: trips.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                  height: 10,
                ),
                shrinkWrap: true,
                itemBuilder: (_, int index) {
                  return TripImageCard(
                    d: trips[index],
                    //tag: trips[index].code!,
                  );
                },
              ), */
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
