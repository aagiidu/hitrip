import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../blocs/sign_in_block.dart';
import '../config/config.dart';
import '../pages/search.dart';

class Header extends StatefulWidget {
  final bool showSearch;
  const Header({super.key, this.showSearch = true});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  late SignInBloc sb;

  @override
  void initState() {
    super.initState();
  }

  facebookSignIn() async {
    await sb.signInwithFacebook().then((_) {
      print('SignInComplete');
    });
  }

  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    foregroundColor: Colors.black87,
    minimumSize: const Size(88, 36),
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2.0)),
    ),
  );

  Future<Future> _showConfirmDialog(BuildContext context) async {
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
                    onPressed: () {
                      Navigator.of(context).pop(true);
                      facebookSignIn();
                    },
                  ),
                ],
              );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    sb = Provider.of<SignInBloc>(context);
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(left: 15, right: 15, top: 30, bottom: 20),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      Config().appName,
                      style: TextStyle(
                          fontSize: 22,
                          fontFamily: 'Muli',
                          fontWeight: FontWeight.w900,
                          color: Colors.grey[800]),
                    ),
                    Text(
                      Config().slogan,
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600]),
                    )
                  ],
                ),
                const Spacer(),
                InkWell(
                  onTap: () => _showConfirmDialog(context),
                  child: sb.isSignedIn && sb.imageUrl != null
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(
                            sb.imageUrl ?? '',
                          ),
                          radius: 30,
                        )
                      : Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              shape: BoxShape.circle,
                              image: const DecorationImage(
                                  image: AssetImage('assets/images/icon.png'),
                                  fit: BoxFit.cover)),
                        ),
                )
              ],
            ),
          ),
          widget.showSearch
              ? const SizedBox(
                  height: 25,
                )
              : Container(),
          widget.showSearch
              ? InkWell(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(left: 5, right: 5),
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      border: Border.all(color: Colors.grey[300]!, width: 0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.search,
                            color: Colors.grey[600],
                            size: 20,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Газрын нэрээр хайх',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.blueGrey[700],
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SearchPage()));
                  },
                )
              : Container(),
        ],
      ),
    );
  }
}
