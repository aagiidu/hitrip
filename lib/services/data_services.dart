import '../models/trip.dart';
import '../models/zam_daguuh.dart';
import '../models/zorih_uzmer.dart';
import './../data/tripdata.dart' as tData;
import '../models/place.dart';
import '../models/aimag.dart';

class DataService {
  List<TripModel> tripList() {
    return tData.TRIPDATA.map((e) => TripModel.fromJson(e)).toList();
  }

  List<Place> placeList() {
    return tData.PLACEDATA.map((e) => Place.fromJson(e)).toList();
  }

  TripModel? tripByCode(String tripCode) {
    Map<String, dynamic> trip =
        tData.TRIPDATA.where((t) => t['code'] == tripCode).first;
    return trip.isNotEmpty ? TripModel.fromJson(trip) : null;
  }

  List<Place> getPlaces(String? tripCode) {
    List filtered = tripCode != null
        ? tData.PLACEDATA.where((p) => p['trip'] == tripCode).toList()
        : tData.PLACEDATA;
    return filtered.map((e) => Place.fromJson(e)).toList();
  }

  List<ZorihUzmer> getUzmerByPlace(String? placeCode) {
    List filtered =
        tData.ZORIHUZMER.where((e) => e['place'] == placeCode).toList();
    return filtered.map((e) => ZorihUzmer.fromJson(e)).toList();
  }

  List<ZorihUzmer> getUzmerByTrip(String? tripCode) {
    List filtered =
        tData.ZORIHUZMER.where((e) => e['trip'] == tripCode).toList();
    return filtered.map((e) => ZorihUzmer.fromJson(e)).toList();
  }

  Map<String, List> getUzmerMapped(String? tripCode) {
    List<Place> tripPlaces = getPlaces(tripCode);
    Map<String, List> data = {};
    for (var i = 0; i < tripPlaces.length; i++) {
      data[tripPlaces[i].code!] = getUzmerByPlace(tripPlaces[i].code!);
    }
    return data;
  }

  List<ZamDaguuh> getZamDaguuhByPlace(String? placeCode) {
    List filtered =
        tData.ZAMDAGUUH.where((e) => e['zgId'] == placeCode).toList();
    return filtered.map((e) => ZamDaguuh.fromJson(e)).toList();
  }

  List<TripModel> getRelatedTrips(String placeName) {
    List filtered = tData.PLACEDATA
        .where((p) =>
            (p["placeName"].toLowerCase().contains(placeName.toLowerCase())))
        .toList();
    if (filtered.isEmpty) return [];
    List<TripModel> relatedTrips = [];
    for (var place in filtered) {
      TripModel? trip = tripByCode(place["trip"]);
      if (trip != null) {
        relatedTrips.add(trip);
      }
    }
    return relatedTrips;
  }

  List<Aimag> aimagList() {
    return tData.AIMAGSUM.map((e) => Aimag.fromJson(e)).toList();
  }
}
