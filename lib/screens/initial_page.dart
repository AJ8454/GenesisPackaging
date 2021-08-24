import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/connection_error.dart';
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
          ? ConnectionError()
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
                } else {
                  return AuthScreen();
                }
              },
            ),
    );
  }
}
