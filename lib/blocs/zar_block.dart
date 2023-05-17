import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:intl/intl.dart';
// import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/app_services.dart';
// import 'package:the_apple_sign_in/the_apple_sign_in.dart';

class ZarBloc extends ChangeNotifier {
  ZarBloc() {}

  bool _guestUser = false;
  bool get guestUser => _guestUser;

  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;

  bool _hasError = false;
  bool get hasError => _hasError;

  String? _errorCode;
  String? get errorCode => _errorCode;

  String? _serial;
  String? get serial => _serial;

  String? _name;
  String? get name => _name;

  String? _uid;
  String? get uid => _uid;

  String? _email;
  String? get email => _email;

  String? _imageUrl;
  String? get imageUrl => _imageUrl;

  String? _joiningDate;
  String? get joiningDate => _joiningDate;

  String? _signInProvider;
  String? get signInProvider => _signInProvider;

  String? _token;
  String? get signToken => _token;

  String? timestamp;

  Future validateSerial(String s) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    _serial = s;
    await sp.setString('serial', s);
    notifyListeners();
  }

  Future checkSubscription(String serial) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    _serial = sp.getString('serial');
    notifyListeners();
  }

  Future signInwithFacebook() async {
    print('### signInwithFacebook starts ###');
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      final userData = await FacebookAuth.instance.getUserData();
      String name = userData['name'];
      String email = userData['email'];
      String uid = userData['id'];
      Map data = {"name": name, "email": email, "fbid": uid};
      final response = await AppService().postReq('register/fbuser', data);
      if (response != null && response.data['status'] == 'success') {
        print('### access response element ###');
        // print(response.statusCode);
        print(response.data['data']);
        print(response.data['token']);
        // {"status":"success",
        // "data":{"fbid":10160265385893054,"name":"Altangerel Du","email":"altanguerel@yahoo.com","status":0,"trips":[],"_id":"645b828ad3b56b7059a9183a","__v":0}}
        _isSignedIn = true;
        _name = userData['name'];
        _email = userData['email'];
        _imageUrl = userData['picture']['data']['url'];
        _uid = userData['id'];
        _token = response.data['token'];
        setSignIn(_token);
        // final _accessToken = result.accessToken!;
        _hasError = false;
      } else {
        _hasError = true;
      }
      notifyListeners();
    } else {
      print(result.status);
      print(result.message);
    }

    // User currentUser;
  }

  Future<bool> checkUserExists() async {
    if (true) {
      return true;
    } else {
      return false;
    }
  }

  /* Future getJoiningDate() async {
    DateTime now = DateTime.now();
    String _date = DateFormat('yyyy-MM-dd').format(now);
    _joiningDate = _date;
    notifyListeners();
  } */

  /* Future saveDataToSP() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString('serial', _name!);
  } */

  Future getDataFromSp() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    _serial = sp.getString('serial');
    notifyListeners();
  }

  Future setSignIn(String? token) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    if (token != null) {
      sp.setString('token', token);
      sp.setBool('signed_in', true);
      _isSignedIn = true;
    } else {
      sp.setString('token', '');
      sp.setBool('signed_in', false);
      _isSignedIn = false;
    }
    notifyListeners();
  }

  void checkSignIn() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    _token = sp.getString('token');
    _isSignedIn = sp.getBool('signed_in') ?? false;
    notifyListeners();
  }

  Future userSignout() async {
    await clearAllData();
    _isSignedIn = false;
    _guestUser = false;
    notifyListeners();
    /* if (_signInProvider == 'facebook') {
      return true;
    } else {
      return true;
    } */
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
    sp.clear();
  }

  Future guestSignout() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setBool('guest_user', false);
    _guestUser = false;
    notifyListeners();
  }
}
