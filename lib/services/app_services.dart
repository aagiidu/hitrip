import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;
import '../config/config.dart';

class AppService {
  final dio = Dio();
  final String apiUrl = Config().apiUrl;

  Future postReq(String url, Map data) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString('token');
    print('####### postReq token #######');
    print(token);
    dio.options.headers['Authorization'] = 'Bearer $token';
    return await dio.post('$apiUrl/$url', data: data);
  }

  Future getReq(String url) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString('token');
    print('####### getReq token #######');
    print(token);
    dio.options.headers['Authorization'] = 'Bearer $token';
    return await dio.get('$apiUrl/$url');
  }

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
