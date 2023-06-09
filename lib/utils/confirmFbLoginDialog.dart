import 'package:flutter/material.dart';
import '../blocs/sign_in_block.dart';

Future<Future> showFBConfirmDialog(
    BuildContext context, SignInBloc sb, next) async {
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    foregroundColor: Colors.black87,
    backgroundColor: Colors.black12,
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
              content: SizedBox(
                width: MediaQuery.of(context).size.width * 0.80,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 15),
                    const Text("Та эхлээд нэвтэрч орно уу"),
                    const SizedBox(height: 8),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                          sb.signInwithFacebook().then((_) {
                            if (next != null) {
                              next();
                            }
                          });
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith(
                                (states) => const Color(0xFF385898)),
                            shape: MaterialStateProperty.resolveWith((states) =>
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)))),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.facebook,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Facebook-ээр нэвтрэх',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            )
                          ],
                        )),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  style: flatButtonStyle,
                  child: const Text("Болих"),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
              ],
            );
    },
  );
}
