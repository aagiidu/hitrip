import 'package:flutter/material.dart';
import '../blocs/sign_in_block.dart';

Future<Future> showFBConfirmDialog(
    BuildContext context, SignInBloc sb, next) async {
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    foregroundColor: Colors.black87,
    minimumSize: const Size(88, 36),
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2.0)),
    ),
  );

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return sb.isSignedIn
          ? AlertDialog(
              /* title: const Text("Confirm"), */
              content: const Text("Та гарах гэж байна уу?"),
              actions: <Widget>[
                TextButton(
                  style: flatButtonStyle,
                  child: const Text("Болих"),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                TextButton(
                  style: flatButtonStyle,
                  child: const Text("Гарах"),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                    sb.userSignout();
                  },
                ),
              ],
            )
          : AlertDialog(
              /* title: const Text("Confirm"), */
              content: const Text("Facebook-ээр нэвтрэх үү?"),
              actions: <Widget>[
                TextButton(
                  style: flatButtonStyle,
                  child: const Text("Болих"),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                TextButton(
                  style: flatButtonStyle,
                  child: const Text("Нэвтрэх"),
                  onPressed: () async {
                    Navigator.of(context).pop(true);
                    sb.signInwithFacebook().then((_) {
                      if (next != null) {
                        print('### callback should be called ###');
                        next();
                      }
                    });
                  },
                ),
              ],
            );
    },
  );
}
