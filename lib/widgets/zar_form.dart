import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../blocs/sign_in_block.dart';
import '../config/config.dart';
import '../services/app_services.dart';
import '../utils/toast.dart';

class ZarForm extends StatefulWidget {
  final bool showSearch;
  const ZarForm({super.key, this.showSearch = true});

  @override
  State<ZarForm> createState() => _ZarFormState();
}

class _ZarFormState extends State<ZarForm> {
  late SignInBloc sb;
  TextEditingController ctrl = TextEditingController();
  bool loading = false;
  String resultMessage = '';

  @override
  void initState() {
    super.initState();
  }

  Future<void> insertZar() async {
    setState(() {
      loading = true;
    });
    final response =
        await AppService().postReq('user/zar/add', {"body": ctrl.text});
    print('### insertZar response ###');
    print(response.data);
    if (response != null && response.data['status'] == 'success') {
      setState(() {
        resultMessage = 'Таны зар амжилттай нэмэгдлээ';
        ctrl.text = '';
        loading = false;
      });
    } else {
      setState(() {
        resultMessage = 'Зар оруулахад алдаа гарлаа';
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    sb = Provider.of<SignInBloc>(context);
    return loading
        ? const Center(
            child: SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(),
            ),
          )
        : Card(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  const Text('Зар оруулах'),
                  TextFormField(
                    maxLines: 8,
                    autofocus: true,
                    controller: ctrl,
                    style: const TextStyle(fontSize: 14),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.symmetric(horizontal: 15)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.teal)),
                        onPressed: () async {
                          ctrl.text = '';
                        },
                        child: const Text(
                          'Арилгах',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 15),
                      TextButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.symmetric(horizontal: 15)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blueAccent)),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          insertZar();
                        },
                        child: const Text(
                          'Оруулах',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  resultMessage != ''
                      ? Card(
                          color: const Color.fromARGB(255, 204, 224, 233),
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(resultMessage),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      resultMessage = '';
                                    });
                                  },
                                  icon: const Icon(Icons.close),
                                )
                              ],
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          );
  }
}
