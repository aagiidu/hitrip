import 'dart:io';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;

import '../config/config.dart';
import '../utils/toast.dart';

class AppService {
  Future<bool?> checkInternet() async {
    bool? internet;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        internet = true;
      }
    } on SocketException catch (_) {
      internet = false;
    }
    return internet;
  }

  Future openLink(context, String url) async {
    if (await urlLauncher.canLaunch(url)) {
      urlLauncher.launch(url);
    } else {
      // openToast1(context, "Can't launch the url");
    }
  }

  Future openEmailSupport(context) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: Config().supportEmail,
      query: 'subject=About ${Config().appName}&body=',
    );

    var url = params.toString();
    if (await urlLauncher.canLaunch(url)) {
      await urlLauncher.launch(url);
    } else {
      // openToast1(context, "Can't open the email app");
    }
  }
}
