import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<dynamic> nextScreen(context, page) async {
  var back = await Navigator.push(
      context, MaterialPageRoute(builder: (context) => page));
  if (back != null) {
    return back;
  }
}

void nextScreeniOS(context, page) {
  Navigator.push(context, CupertinoPageRoute(builder: (context) => page));
}

void nextScreenCloseOthers(context, page) {
  Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(builder: (context) => page), (route) => false);
}

void nextScreenReplace(context, page) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}

void nextScreenPopup(context, page) {
  Navigator.push(
    context,
    MaterialPageRoute(fullscreenDialog: true, builder: (context) => page),
  );
}
