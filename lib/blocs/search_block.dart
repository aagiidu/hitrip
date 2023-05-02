import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/place.dart';
import '../models/trip.dart';
import '../services/data_services.dart';

class SearchBloc with ChangeNotifier {
  SearchBloc() {
    getRecentSearchList();
  }

  List<String> _recentSearchData = [];
  List<String> get recentSearchData => _recentSearchData;

  Map<String, dynamic> _searchResult = {};
  Map<String, dynamic> get searchResult => _searchResult;
  String _searchText = '';
  String get searchText => _searchText;

  List<Place> _resultPlaces = [];
  List<Place> get resultPlaces => _resultPlaces;
  bool _searchStarted = false;
  bool get searchStarted => _searchStarted;
  DataService ds = DataService();

  TextEditingController _textFieldCtrl = TextEditingController();
  TextEditingController get textfieldCtrl => _textFieldCtrl;

  List<TripModel> _relatedTrips = [];
  List<TripModel> get relatedTrips => _relatedTrips;

  // final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future getRecentSearchList() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    _recentSearchData = sp.getStringList('recent_search_data') ?? [];
    notifyListeners();
  }

  Future addToSearchList(String value) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    _recentSearchData.add(value);
    await sp.setStringList('recent_search_data', _recentSearchData);
    notifyListeners();
  }

  Future removeFromSearchList(String value) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    _recentSearchData.remove(value);
    await sp.setStringList('recent_search_data', _recentSearchData);
    notifyListeners();
  }

  findPlace() {
    // _relatedTrips = [];
    List<Place> placeList = ds.getPlaces(null);
    print('====== placeList =====');
    print(placeList);
    print('====== Seatch Text: $_searchText ==========');
    List<Place> filtered = placeList
        .where(
            (u) => (u.name!.toLowerCase().contains(_searchText.toLowerCase())))
        .toList();

    /* for (var i = 0; i < filtered.length; i++) {
      TripModel? trip = ds.tripByCode(filtered[i].trip!);
      if (trip != null) {
        _relatedTrips.add(trip);
      }
    } */
    List<Place> noDuplicate = [];
    for (var i = 0; i < filtered.length; i++) {
      List<Place> existing = noDuplicate
          .where((dup) =>
              (dup.name!.toLowerCase() == filtered[i].name!.toLowerCase()))
          .toList();
      if (existing.isEmpty) {
        noDuplicate.add(filtered[i]);
      }
    }

    _resultPlaces = noDuplicate;
    print('========== Result ==========');
    print(_resultPlaces);
    /* _searchResult = {
      "place": [filtered[0]],
      "tripList": tripList,
    }; */
    // notifyListeners();
  }

  getAllPlaces() {
    _textFieldCtrl.text = '';
    _searchText = '';
    _searchStarted = true;
    List<Place> filtered = ds.getPlaces(null);

    List<Place> noDuplicate = [];
    for (var i = 0; i < filtered.length; i++) {
      List<Place> existing = noDuplicate
          .where((dup) =>
              (dup.name!.toLowerCase() == filtered[i].name!.toLowerCase()))
          .toList();
      if (existing.isEmpty) {
        noDuplicate.add(filtered[i]);
      }
    }
    noDuplicate.sort((a, b) => a.name!.compareTo(b.name!));
    _resultPlaces = noDuplicate;
    notifyListeners();
  }

  setSearchText(value) {
    _textFieldCtrl.text = value;
    _searchText = value;
    _searchStarted = true;
    findPlace();
    notifyListeners();
  }

  saerchInitialize() {
    _textFieldCtrl.clear();
    _searchStarted = false;
    notifyListeners();
  }
}
