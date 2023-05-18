import 'package:flutter/material.dart';
import 'package:hitrip/models/Zar.dart';
import 'package:provider/provider.dart';
import '../blocs/sign_in_block.dart';
import '../services/app_services.dart';
import '../utils/confirmFbLoginDialog.dart';
import '../widgets/header.dart';
import 'package:intl/intl.dart';

import '../widgets/zar_form.dart';

class ZarList extends StatefulWidget {
  const ZarList({Key? key}) : super(key: key);

  @override
  _ZarListState createState() => _ZarListState();
}

class _ZarListState extends State<ZarList> with AutomaticKeepAliveClientMixin {
  ScrollController? controller = ScrollController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late SignInBloc sb;
  bool showZarForm = false;

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
    setState(() {
      zarList = [];
    });
    final response = await AppService().getReq('zar/list');
    if (response != null && response.data['status'] == 'success') {
      List<dynamic> json = response.data['data'];
      setState(() {
        zarList = json.map((z) => Zar.fromJson(z)).toList();
      });
    }
  }

  facebookSignIn() async {
    await sb.signInwithFacebook().then((_) {
      print('SignInComplete');
    });
  }

  Future<void> getMyZar(BuildContext context) async {
    if (!sb.isSignedIn) {
      showFBConfirmDialog(context, sb, myZarList);
    } else {
      myZarList();
    }
  }

  Future<void> myZarList() async {
    setState(() {
      zarList = [];
    });
    final response = await AppService().getReq('user/my/zar');
    if (response != null && response.data['status'] == 'success') {
      List<dynamic> json = response.data['data'];
      setState(() {
        zarList = json.map((z) => Zar.fromJson(z)).toList();
      });
    }
  }

  Future<void> deleteZar(id) async {
    final response = await AppService().postReq('user/zar/delete', {"id": id});
    if (response != null && response.data['status'] == 'success') {
      setState(() {
        zarList = zarList.where((z) => z.id != id).toList();
      });
    }
  }

  Future<void> addZar(BuildContext context) async {
    if (!sb.isSignedIn) {
      showFBConfirmDialog(context, sb, openZarForm);
    } else {
      openZarForm();
    }
  }

  openZarForm() {
    setState(() {
      showZarForm = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    sb = Provider.of<SignInBloc>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            // const Header(showSearch: false),
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      bottom: BorderSide(
                    color: Colors.black54,
                    width: 0.5,
                  ))),
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.symmetric(horizontal: 15)),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blueAccent)),
                    onPressed: () async {
                      if (showZarForm) {
                        setState(() {
                          showZarForm = false;
                        });
                      }
                      getZarList();
                    },
                    child: const Text(
                      'Бүх зар',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.symmetric(horizontal: 15)),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blueAccent)),
                    onPressed: () async {
                      if (showZarForm) {
                        setState(() {
                          showZarForm = false;
                        });
                      }
                      getMyZar(context);
                    },
                    child: const Text(
                      'Миний зарууд',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.symmetric(horizontal: 15)),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green)),
                    onPressed: () => addZar(context),
                    child: const Text(
                      'Зар оруулах',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: showZarForm
                  ? const ZarForm()
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      controller: controller,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: zarList.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(
                        height: 5,
                      ),
                      shrinkWrap: true,
                      itemBuilder: (_, int index) {
                        Zar z = zarList[index];
                        return Card(
                            key: Key(z.id),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        z.name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        DateFormat('yyyy-MM-dd HH:mm:ss')
                                            .format(z.timestamp),
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    z.body,
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                  ((sb.isSignedIn &&
                                              sb.fbid.toString() == z.fbid) ||
                                          sb.isAdmin)
                                      ? InkWell(
                                          onTap: () => deleteZar(z.id),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: const [
                                              Icon(Icons.delete_outlined,
                                                  color: Colors.blue, size: 15),
                                              SizedBox(width: 3),
                                              Text(
                                                'Устгах',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.blue,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )
                                            ],
                                          ),
                                        )
                                      : Container()
                                ],
                              ),
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
