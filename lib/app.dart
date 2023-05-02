import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'blocs/search_block.dart';
import 'config/config.dart';
import 'pages/splash.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SearchBloc>(create: (context) => SearchBloc()),
      ],
      child: MaterialApp(
          scaffoldMessengerKey: scaffoldMessengerKey,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: Config.appThemeColor,
            iconTheme: IconThemeData(color: Colors.grey[900]),
            fontFamily: 'Manrope',
            scaffoldBackgroundColor: Colors.grey[100],
            appBarTheme: AppBarTheme(
                color: Colors.white,
                elevation: 0,
                iconTheme: IconThemeData(
                  color: Colors.grey[800],
                ),
                titleTextStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Manrope',
                    color: Colors.grey[900])),
          ),
          home: const SplashPage()),
    );
  }
}
