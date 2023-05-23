import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hitrip/blocs/sign_in_block.dart';
import 'package:hitrip/models/trip.dart';
import 'package:provider/provider.dart';

import '../utils/confirmFbLoginDialog.dart';

class Subsciption extends StatefulWidget {
  final TripModel? selectedTrip;
  const Subsciption({super.key, this.selectedTrip});

  @override
  State<Subsciption> createState() => _SubsciptionState();
}

class _SubsciptionState extends State<Subsciption>
    with AutomaticKeepAliveClientMixin {
  late bool sel;
  late TripModel? trip;
  late SignInBloc sb;
  late String payType;
  late int amount;

  @override
  void initState() {
    super.initState();
    sb = context.read<SignInBloc>();
    sel = widget.selectedTrip != null;
    if (sel) {
      trip = widget.selectedTrip;
    }
  }

  Future<void> activationStart(BuildContext context) async {
    Navigator.pop(context);
    if (!sb.isSignedIn) {
      showFBConfirmDialog(context, sb, proceedPayment);
    } else {
      proceedPayment();
    }
  }

  Future<void> proceedPayment() async {
    // invoice create api call
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Аялал идэвхижүүлэх')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            sel
                ? Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blue[200]!,
                        ),
                        color: Colors.blue[100],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8))),
                    child: Column(
                      children: [
                        const Text('Сонгосон аялалын нэр:'),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          trip!.name!,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text("Үнэ: ₮9'800",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 3, 76, 136))),
                        const SizedBox(
                          height: 5,
                        ),
                        TextButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.symmetric(horizontal: 40)),
                            backgroundColor: MaterialStateProperty.resolveWith(
                                (states) => Colors.blue),
                          ),
                          onPressed: () {
                            setState(() {
                              payType = 'one';
                              amount = 9800;
                            });
                            activationStart(context);
                          },
                          child: const Text(
                            'Идэвхижүүлэх',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
            const SizedBox(
              height: 16,
            ),
            const Text(
              'эсвэл',
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.green[200]!,
                  ),
                  color: Colors.green[100],
                  borderRadius: const BorderRadius.all(Radius.circular(8))),
              child: Column(
                children: [
                  const Text('Бүх аялалыг идэвхижүүлэх'),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    "Үнэ: ₮98'000",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 1, 116, 5)),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.symmetric(horizontal: 40)),
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.green),
                    ),
                    onPressed: () {
                      setState(() {
                        payType = 'all';
                        amount = 98000;
                      });
                      activationStart(context);
                    },
                    child: const Text(
                      'Сонгох',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => throw UnimplementedError();
}
