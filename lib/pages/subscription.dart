import 'package:flutter/material.dart';
import 'package:hitrip/blocs/sign_in_block.dart';
import 'package:hitrip/models/bank.dart';
import 'package:hitrip/models/trip.dart';
import 'package:hitrip/pages/bank_list.dart';
import 'package:provider/provider.dart';

import '../services/app_services.dart';
import '../utils/confirmFbLoginDialog.dart';
import '../utils/next_screen.dart';

class Subsciption extends StatefulWidget {
  final TripModel? selectedTrip;
  const Subsciption({super.key, this.selectedTrip});

  @override
  State<Subsciption> createState() => _SubsciptionState();
}

class _SubsciptionState extends State<Subsciption> {
  late bool sel;
  late TripModel? trip;
  late SignInBloc sb;
  late String tripCode;
  String invoiceId = '';
  late int amount;
  List<Bank> banks = [];

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
    if (!sb.isSignedIn) {
      showFBConfirmDialog(context, sb, () => proceedPayment(context));
    } else {
      proceedPayment(context);
    }
  }

  Future<void> proceedPayment(BuildContext ctx) async {
    // invoice create api call
    Map<String, dynamic> data = {"tripCode": tripCode, "amount": amount};
    try {
      final response = await AppService().postReq('user/request/invoice', data);
      if (response != null && response.data['status'] == 'success') {
        List<dynamic> urls = response.data['data']['urls'];
        List<Bank> temp = urls.map((b) => Bank.fromJson(b)).toList();
        setState(() {
          invoiceId = response.data['data']['invoice_id'];
          banks = temp;
        });
        // ignore: use_build_context_synchronously
        var back = await nextScreen(ctx, BankList(banks: banks));
        if (back != null) {
          print('###### back ######');
          print(back);
          // check payment. Geree hiisnii daraa ashuglana
          /* final response =
              await AppService().getReq('payment/check/$invoiceId');
          if (response != null && response.data['status'] == 'success') {
            print('### Payment Check ###');
            print(response.data);
          } */
        }
      }
    } catch (e) {
      print('Qpay error');
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
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
                              tripCode = trip!.code;
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
                        tripCode = 'all';
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
}
