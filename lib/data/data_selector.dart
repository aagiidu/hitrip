import './path01.dart';
import './path02.dart';
import './path03.dart';
import './path04.dart';
import './path05.dart';
import './path06.dart';
import './path07.dart';
import './path08.dart';
import './path09.dart';
import './path10.dart';
import './path11.dart';
import './path12.dart';
import './path13.dart';
import './path14.dart';
import './path15.dart';
import './path16.dart';
import './path17.dart';
import './path18.dart';
import './path19.dart';
import './path20.dart';

class DataSelector {
  final Map<String, Map<String, dynamic>> _tripData = {
    'TR001': TR001,
    'TR002': TR002,
    'TR003': TR003,
    'TR004': TR004,
    'TR005': TR005,
    'TR006': TR006,
    'TR007': TR007,
    'TR008': TR008,
    'TR009': TR009,
    'TR010': TR010,
    'TR011': TR011,
    'TR012': TR012,
    'TR013': TR013,
    'TR014': TR014,
    'TR015': TR015,
    'TR016': TR016,
    'TR017': TR017,
    'TR018': TR018,
    'TR019': TR019,
    'TR020': TR020,
  };

  getPath(String tripCode) {
    return _tripData[tripCode];
  }
}
