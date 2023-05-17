import 'package:flutter/material.dart';
import 'package:hitrip/models/Zar.dart';
import '../models/trip.dart';
import '../services/app_services.dart';
import '../services/data_services.dart';
import '../widgets/header.dart';
import '../widgets/trip_image_card.dart';

class ZarList extends StatefulWidget {
  const ZarList({Key? key}) : super(key: key);

  @override
  _ZarListState createState() => _ZarListState();
}

class _ZarListState extends State<ZarList> with AutomaticKeepAliveClientMixin {
  ScrollController? controller = ScrollController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<Zar> zarList = [];

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 0)).then((value) {
      // controller = ScrollController()..addListener(_scrollListener);
      getZarList();
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /* void _scrollListener() {
    print('####### _scrollListener ######');
    // getZarList();
  } */

  Future<void> getZarList() async {
    final response = await AppService().getReq('user/zar/list');
    print('####### getZarList ######');
    print(response.data);
    if (response != null && response.data['status'] == 'success') {
      List<dynamic> json = response.data['data'];
      setState(() {
        zarList = json.map((z) => Zar.fromJson(z)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Header(showSearch: false),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(15),
                controller: controller,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: zarList.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                  height: 10,
                ),
                shrinkWrap: true,
                itemBuilder: (_, int index) {
                  Zar z = zarList[index];
                  return Card(
                      key: Key(z.id),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(z.title),
                              Text(z.timestamp.toString()),
                            ],
                          ),
                          Text(z.body),
                        ],
                      ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
