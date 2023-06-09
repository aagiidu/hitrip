import 'package:flutter/material.dart';
import 'package:hitrip/models/bank.dart';
import 'package:hitrip/services/app_services.dart';

class BankList extends StatefulWidget {
  final List<Bank> banks;
  const BankList({super.key, required this.banks});

  @override
  State<BankList> createState() => _BankListState();
}

class _BankListState extends State<BankList> {
  List<Bank> banks = [];
  List<dynamic> temp = [
    {
      "name": "qPay wallet",
      "description": "qPay хэтэвч",
      "logo":
          "https://s3.qpay.mn/p/e9bbdc69-3544-4c2f-aff0-4c292bc094f6/launcher-icon-ios.jpg",
      "link":
          "qpaywallet://q?qPay_QRcode=0002010102121531279404962794049600230510458969827440014A00000084300010108CAXBMNUB02105003398216520460105303496540498005802MN5912TESTMERCHANT6011Ulaanbaatar6263012594949dc4a35f42ff97dab887e0505TR0010721VIEq2AqUbkE9Sptzlh0ua7106QPP_QR7815820049046391391790222800201630465F3"
    },
    {
      "name": "Khan bank",
      "description": "Хаан банк",
      "logo": "https://qpay.mn/q/logo/khanbank.png",
      "link":
          "khanbank://q?qPay_QRcode=0002010102121531279404962794049600230510458969827440014A00000084300010108CAXBMNUB02105003398216520460105303496540498005802MN5912TESTMERCHANT6011Ulaanbaatar6263012594949dc4a35f42ff97dab887e0505TR0010721VIEq2AqUbkE9Sptzlh0ua7106QPP_QR7815820049046391391790222800201630465F3"
    },
    {
      "name": "State bank",
      "description": "Төрийн банк",
      "logo": "https://qpay.mn/q/logo/statebank.png",
      "link":
          "statebank://q?qPay_QRcode=0002010102121531279404962794049600230510458969827440014A00000084300010108CAXBMNUB02105003398216520460105303496540498005802MN5912TESTMERCHANT6011Ulaanbaatar6263012594949dc4a35f42ff97dab887e0505TR0010721VIEq2AqUbkE9Sptzlh0ua7106QPP_QR7815820049046391391790222800201630465F3"
    },
    {
      "name": "Xac bank",
      "description": "Хас банк",
      "logo": "https://qpay.mn/q/logo/xacbank.png",
      "link":
          "xacbank://q?qPay_QRcode=0002010102121531279404962794049600230510458969827440014A00000084300010108CAXBMNUB02105003398216520460105303496540498005802MN5912TESTMERCHANT6011Ulaanbaatar6263012594949dc4a35f42ff97dab887e0505TR0010721VIEq2AqUbkE9Sptzlh0ua7106QPP_QR7815820049046391391790222800201630465F3"
    },
    {
      "name": "Trade and Development bank",
      "description": "TDB online",
      "logo": "https://qpay.mn/q/logo/tdbbank.png",
      "link":
          "tdbbank://q?qPay_QRcode=0002010102121531279404962794049600230510458969827440014A00000084300010108CAXBMNUB02105003398216520460105303496540498005802MN5912TESTMERCHANT6011Ulaanbaatar6263012594949dc4a35f42ff97dab887e0505TR0010721VIEq2AqUbkE9Sptzlh0ua7106QPP_QR7815820049046391391790222800201630465F3"
    },
    {
      "name": "Most money",
      "description": "МОСТ мони",
      "logo": "https://qpay.mn/q/logo/most.png",
      "link":
          "most://q?qPay_QRcode=0002010102121531279404962794049600230510458969827440014A00000084300010108CAXBMNUB02105003398216520460105303496540498005802MN5912TESTMERCHANT6011Ulaanbaatar6263012594949dc4a35f42ff97dab887e0505TR0010721VIEq2AqUbkE9Sptzlh0ua7106QPP_QR7815820049046391391790222800201630465F3"
    },
    {
      "name": "National investment bank",
      "description": "Үндэсний хөрөнгө оруулалтын банк",
      "logo": "https://qpay.mn/q/logo/nibank.jpeg",
      "link":
          "nibank://q?qPay_QRcode=0002010102121531279404962794049600230510458969827440014A00000084300010108CAXBMNUB02105003398216520460105303496540498005802MN5912TESTMERCHANT6011Ulaanbaatar6263012594949dc4a35f42ff97dab887e0505TR0010721VIEq2AqUbkE9Sptzlh0ua7106QPP_QR7815820049046391391790222800201630465F3"
    },
    {
      "name": "Chinggis khaan bank",
      "description": "Чингис Хаан банк",
      "logo": "https://qpay.mn/q/logo/ckbank.png",
      "link":
          "ckbank://q?qPay_QRcode=0002010102121531279404962794049600230510458969827440014A00000084300010108CAXBMNUB02105003398216520460105303496540498005802MN5912TESTMERCHANT6011Ulaanbaatar6263012594949dc4a35f42ff97dab887e0505TR0010721VIEq2AqUbkE9Sptzlh0ua7106QPP_QR7815820049046391391790222800201630465F3"
    },
    {
      "name": "Capitron bank",
      "description": "Капитрон банк",
      "logo": "https://qpay.mn/q/logo/capitronbank.png",
      "link":
          "capitronbank://q?qPay_QRcode=0002010102121531279404962794049600230510458969827440014A00000084300010108CAXBMNUB02105003398216520460105303496540498005802MN5912TESTMERCHANT6011Ulaanbaatar6263012594949dc4a35f42ff97dab887e0505TR0010721VIEq2AqUbkE9Sptzlh0ua7106QPP_QR7815820049046391391790222800201630465F3"
    },
    {
      "name": "Bogd bank",
      "description": "Богд банк",
      "logo": "https://qpay.mn/q/logo/bogdbank.png",
      "link":
          "bogdbank://q?qPay_QRcode=0002010102121531279404962794049600230510458969827440014A00000084300010108CAXBMNUB02105003398216520460105303496540498005802MN5912TESTMERCHANT6011Ulaanbaatar6263012594949dc4a35f42ff97dab887e0505TR0010721VIEq2AqUbkE9Sptzlh0ua7106QPP_QR7815820049046391391790222800201630465F3"
    },
    {
      "name": "Trans bank",
      "description": "Тээвэр хөгжлийн банк",
      "logo": "https://qpay.mn/q/logo/transbank.png",
      "link":
          "transbank://q?qPay_QRcode=0002010102121531279404962794049600230510458969827440014A00000084300010108CAXBMNUB02105003398216520460105303496540498005802MN5912TESTMERCHANT6011Ulaanbaatar6263012594949dc4a35f42ff97dab887e0505TR0010721VIEq2AqUbkE9Sptzlh0ua7106QPP_QR7815820049046391391790222800201630465F3"
    },
    {
      "name": "M bank",
      "description": "М банк",
      "logo": "https://qpay.mn/q/logo/mbank.png",
      "link":
          "mbank://q?qPay_QRcode=0002010102121531279404962794049600230510458969827440014A00000084300010108CAXBMNUB02105003398216520460105303496540498005802MN5912TESTMERCHANT6011Ulaanbaatar6263012594949dc4a35f42ff97dab887e0505TR0010721VIEq2AqUbkE9Sptzlh0ua7106QPP_QR7815820049046391391790222800201630465F3"
    },
    {
      "name": "Ard App",
      "description": "Ард Апп",
      "logo": "https://qpay.mn/q/logo/ardapp.png",
      "link":
          "ard://q?qPay_QRcode=0002010102121531279404962794049600230510458969827440014A00000084300010108CAXBMNUB02105003398216520460105303496540498005802MN5912TESTMERCHANT6011Ulaanbaatar6263012594949dc4a35f42ff97dab887e0505TR0010721VIEq2AqUbkE9Sptzlh0ua7106QPP_QR7815820049046391391790222800201630465F3"
    }
  ];

  @override
  void initState() {
    super.initState();
    banks = widget.banks;
    // banks = temp.map((b) => Bank.fromJson(b)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Төлбөр'),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, true),
          )),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(
            child: ListView.builder(
              itemCount: banks.length,
              itemBuilder: (BuildContext context, int index) {
                Bank bank = banks[index];
                return Card(
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        bank.logo,
                        height: 40,
                        width: 40,
                      ),
                    ),
                    title: Text(bank.name),
                    onTap: () {
                      AppService().openLink(context, bank.link);
                    },
                  ),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
