import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../screens/aboutus_screen.dart';
import '../widgets/auth_card.dart';
import '../widgets/google_signup_widget.dart';
import '../widgets/header_widgets/nameTitle.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Spacer(),
          Align(
            alignment: Alignment.center,
            child: NameTitle(),
          ),
          const Spacer(),
          Text(
            ' Login to continue',
            style: TextStyle(fontSize: 13.sp),
          ),
          const SizedBox(height: 10),
          OutlinedButton(
            child: Text('Sign In'),
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              side: BorderSide(color: Colors.black),
            ),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AuthCard()),
            ),
          ),
          const Text('or'),
          const SizedBox(height: 10),
          const GoogleSingupButtonWidget(),
          const Spacer(),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AboutUs())),
                  child: Text(
                    'About us',
                    style: TextStyle(
                      color: Colors.brown,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                VerticalDivider(
                  color: Colors.grey,
                  thickness: 1,
                  indent: 12,
                  endIndent: 12,
                  width: 20,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Location',
                    style: TextStyle(
                      color: Colors.brown,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
