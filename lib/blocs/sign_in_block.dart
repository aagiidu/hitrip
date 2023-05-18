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

class SignInBloc extends ChangeNotifier {
  SignInBloc(); /* {
    checkSignIn();
    checkGuestUser();
  } */

  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // final GoogleSignIn _googlSignIn = new GoogleSignIn();
  // final FacebookAuth _fbAuth = FacebookAuth.instance;
  final String defaultUserImageUrl =
      'https://www.seekpng.com/png/detail/115-1150053_avatar-png-transparent-png-royalty-free-default-user.png';
  // final FirebaseFirestore firestore = FirebaseFirestore.instance;

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

  Future setSignIn(data) async {
    print('############ ++ setSignIn ++ ###########');
    print(data['data']);
    print(data['token']);
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
    final response = await AppService().getReq('user/data');
    print('############ checkSignIn ###########');
    print(response.data);
    print(response.data['status']);
    if (response != null && response.data['status'] == 'success') {
      setSignIn(response.data);
    } else {
      userSignout();
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
    sp.clear();
  }

  Future guestSignout() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setBool('guest_user', false);
    _guestUser = false;
    notifyListeners();
  }
}
