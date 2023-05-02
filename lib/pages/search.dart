import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import '../blocs/search_block.dart';
import '../models/place.dart';
import '../utils/empty.dart';
import '../utils/list_card.dart';
import '../utils/snackbar.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    Future.delayed(const Duration())
        .then((value) => context.read<SearchBloc>().saerchInitialize());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldMessengerKey,
      appBar: AppBar(
        title: _searchBar(),
        automaticallyImplyLeading: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 15, bottom: 5),
            child: Text(
              context.watch<SearchBloc>().searchStarted == false
                  ? 'Сүүлийн хайлтууд'
                  : 'хайлтын үр дүн',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
          ),
          context.watch<SearchBloc>().searchStarted == false
              ? const SuggestionsUI()
              : const AfterSearchUI()
        ],
      ),
    );
  }

  Widget _searchBar() {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      child: TextFormField(
        autofocus: true,
        controller: context.watch<SearchBloc>().textfieldCtrl,
        style: TextStyle(
            fontSize: 16, color: Colors.grey[800], fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Газрын нэрээр хайх",
          hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey[800]),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.grey[800],
              size: 25,
            ),
            onPressed: () {
              context.read<SearchBloc>().saerchInitialize();
            },
          ),
        ),
        textInputAction: TextInputAction.search,
        onFieldSubmitted: (value) {
          if (value == '') {
            openSnacbar(scaffoldMessengerKey, 'Хайх үгээ бичнэ үү!');
          } else {
            context.read<SearchBloc>().setSearchText(value);
            context.read<SearchBloc>().addToSearchList(value);
          }
        },
      ),
    );
  }
}

class SuggestionsUI extends StatelessWidget {
  const SuggestionsUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sb = context.watch<SearchBloc>();
    return Expanded(
      child: sb.recentSearchData.isEmpty
          // ignore: prefer_const_constructors
          ? EmptyPage(
              icon: Feather.search,
              message: 'Газрын нэрээр хайх',
              message1: "Одоогоор хайлт хийгээгүй байна",
            )
          : ListView.builder(
              itemCount: sb.recentSearchData.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    sb.recentSearchData[index],
                    style: const TextStyle(fontSize: 17),
                  ),
                  leading: const Icon(CupertinoIcons.time_solid),
                  trailing: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      context
                          .read<SearchBloc>()
                          .removeFromSearchList(sb.recentSearchData[index]);
                    },
                  ),
                  onTap: () {
                    context
                        .read<SearchBloc>()
                        .setSearchText(sb.recentSearchData[index]);
                  },
                );
              },
            ),
    );
  }
}

class AfterSearchUI extends StatelessWidget {
  const AfterSearchUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Place> result = context.watch<SearchBloc>().resultPlaces;

    return Expanded(
        child: result.isEmpty
            ? const EmptyPage(
                icon: Feather.clipboard,
                message: 'Хайлтаар үр дүн олдсонгүй',
                message1: "Дахин оролдож үзнэ үү",
              )
            : ListView.separated(
                padding: const EdgeInsets.all(10),
                itemCount: result.length,
                separatorBuilder: (context, index) => const SizedBox(
                  height: 5,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return ListCard(
                    d: result[index],
                    tag: "search$index",
                    color: Colors.white,
                  );
                },
              ));
  }
}
