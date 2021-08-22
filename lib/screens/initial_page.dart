import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../providers/google_sign_in_provider.dart';
import '../screens/auth_screen.dart';
import '../screens/homeScreens/productOverviewScreen.dart';

class InitialPage extends StatefulWidget {
  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  bool? hasInternet;

  @override
  void initState() {
    hasInternet = false;
    InternetConnectionChecker().onStatusChange.listen((status) {
      final hasInternetAvail = status == InternetConnectionStatus.connected;
      setState(() => this.hasInternet = hasInternetAvail);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: !hasInternet!
          ? AlertDialog(
              title: Text(
                'OOPS! \n NO INTERNET',
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Theme.of(context).errorColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Text(
                'Please turn on the internet connection.',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.grey[500],
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => SystemNavigator.pop(),
                      child: Text(
                        'Exit',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: HexColor('#1A2028'),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                  ],
                )
              ],
            )
          : StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                final provider = Provider.of<GoogleSignInProvider>(context);
                if (provider.isSigningIn) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData) {
                  return ProductOverviewScreen();
                }
                {
                  return AuthScreen();
                }
              },
            ),
    );
  }
}
