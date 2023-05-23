import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/app_services.dart';

class SignInBloc extends ChangeNotifier {
  SignInBloc() {
    checkSignIn();
    // checkGuestUser();
  }

  bool _guestUser = false;
  bool get guestUser => _guestUser;

  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;

  bool _hasError = false;
  bool get hasError => _hasError;

  bool _isAdmin = false;
  bool get isAdmin => _isAdmin;

  String? _errorCode;
  String? get errorCode => _errorCode;

  String? _serial;
  String? get serial => _serial;

  String? _name;
  String? get name => _name;

  String? _uid;
  String? get uid => _uid;

  int? _fbid;
  int? get fbid => _fbid;

  String? _email;
  String? get email => _email;

  String? _imageUrl;
  String? get imageUrl => _imageUrl;

  String? _joiningDate;
  String? get joiningDate => _joiningDate;

  String? _signInProvider;
  String? get signInProvider => _signInProvider;

  String? _token;
  String? get getToken => _token;

  String? timestamp;

  Map<String, bool> _enabledTrips = {};
  Map<String, bool> get enabledTrips => _enabledTrips;

  /* Future validateSerial(String s) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    _serial = s;
    await sp.setString('serial', s);
    notifyListeners();
  }

  Future checkSubscription(String serial) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    _serial = sp.getString('serial');
    notifyListeners();
  } */

  Future signInwithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      final fb = await FacebookAuth.instance.getUserData();
      String name = fb['name'];
      String email = fb['email'];
      String uid = fb['id'];
      Map data = {
        "name": name,
        "email": email,
        "fbid": uid,
        "image": fb['picture']['data']['url']
      };
      final response = await AppService().postReq('register/fbuser', data);
      if (response != null && response.data['status'] == 'success') {
        setSignIn(response.data);
        // final _accessToken = result.accessToken!;
        _hasError = false;
      } else {
        _hasError = true;
      }
      notifyListeners();
    } else {
      print(result.message);
    }
  }

  Future setSignIn(data) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    if (data['token'] != null) {
      _isSignedIn = true;
      _name = data['data']['name'];
      _email = data['data']['email'];
      _imageUrl = data['data']['image'];
      _uid = data['data']['_id'];
      _token = data['token'];
      _fbid = data['data']['fbid'];
      _isAdmin = data['data']['status'] == 2;
      sp.setString('token', data['token']);
      sp.setBool('signed_in', true);
      _isSignedIn = true;
    } else {
      userSignout();
    }
    notifyListeners();
  }

  void checkSignIn() async {
    await setEnabledTrips();
    // await getEnabledTrips();
    try {
      final response = await AppService().getReq('user/data');
      if (response != null && response.data['status'] == 'success') {
        setSignIn(response.data);
      } else {
        userSignout();
      }
    } catch (e) {
      print('checkSignIn catch');
      print(e);
    }

    notifyListeners();
  }

  Future userSignout() async {
    await clearAllData();
    _isSignedIn = false;
    _guestUser = false;
    notifyListeners();
  }

  Future afterUserSignOut() async {
    await userSignout().then((value) async {
      await clearAllData();
      _isSignedIn = false;
      _guestUser = false;
      notifyListeners();
    });
  }

  Future setGuestUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setBool('guest_user', true);
    _guestUser = true;
    notifyListeners();
  }

  void checkGuestUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    _guestUser = sp.getBool('guest_user') ?? false;
    notifyListeners();
  }

  Future clearAllData() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    _isSignedIn = false;
    _token = null;
    sp.setString('token', '');
    sp.setBool('signed_in', false);
  }

  Future guestSignout() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setBool('guest_user', false);
    _guestUser = false;
    notifyListeners();
  }

  Future getEnabledTrips() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    String? enabledStr = sp.getString('enabledTrips');
    if (enabledStr != null) {
      _enabledTrips = jsonDecode(enabledStr);
    } else {
      _enabledTrips = {};
    }
    notifyListeners();
  }

  Future setEnabledTrips() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    Map<String, bool> temp = {
      'all': false,
      'TR002': true,
      'TR005': true,
      'TR007': true,
    };
    String enabledStr = jsonEncode(temp);
    sp.setString('enabledTrips', enabledStr);
    _enabledTrips = temp;
    print('_enabledTrips set');
    print(_enabledTrips);
    notifyListeners();
  }

  bool isEnabled(String tripCode) {
    return _enabledTrips[tripCode] != null && _enabledTrips[tripCode] == true;
  }
}
