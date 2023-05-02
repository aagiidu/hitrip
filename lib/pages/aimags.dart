import 'package:flutter/material.dart';
import '../models/aimag.dart';
import '../services/data_services.dart';

class AimagPage extends StatefulWidget {
  AimagPage({Key? key}) : super(key: key);

  @override
  _AimagPageState createState() => _AimagPageState();
}

class _AimagPageState extends State<AimagPage> {
  DataService ds = DataService();

  List<Aimag> aimags = [];

  @override
  void initState() {
    super.initState();
    aimags = ds.aimagList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Аймаг сумдын мэдээлэл'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(15),
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: aimags.length,
        separatorBuilder: (BuildContext context, int index) => const SizedBox(
          height: 15,
        ),
        itemBuilder: (_, int index) {
          return _AimagCard(aimags[index]);
        },
      ),
    );
  }
}

class _AimagCard extends StatefulWidget {
  final Aimag aimag;
  const _AimagCard(this.aimag, {Key? key}) : super(key: key);

  @override
  State<_AimagCard> createState() => _AimagCardState();
}

class _AimagCardState extends State<_AimagCard> {
  List<Soum> sums = [];
  late Aimag aimag;
  @override
  void initState() {
    super.initState();
    aimag = widget.aimag;
    sums = widget.aimag.sums;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey[200]!,
                blurRadius: 10,
                offset: const Offset(0, 3))
          ]),
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              aimag.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(aimag.details,
                /* HtmlUnescape().convert(
                    parse(d.description).documentElement!.text), */
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[700])),
            const SizedBox(
              height: 10,
            ),
            ExpansionPanelList(
              expandedHeaderPadding: const EdgeInsets.all(0),
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  sums[index].isExpanded = !isExpanded;
                });
              },
              children: sums.map((Soum item) {
                return ExpansionPanel(
                  canTapOnHeader: true,
                  isExpanded: item.isExpanded,
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(item.name));
                  },
                  body: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(item.location),
                          const SizedBox(height: 10),
                          Text(item.desc),
                          const SizedBox(height: 10),
                          Text(item.distance),
                        ]),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
