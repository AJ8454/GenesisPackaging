import 'package:flutter/material.dart';
import 'package:genesis_packaging/screens/aboutus_screen.dart';
import 'package:genesis_packaging/widgets/auth_card.dart';
import 'package:genesis_packaging/widgets/google_signup_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.white,
      body: Column(
        children: [
          Spacer(),
          Align(
            alignment: Alignment.center,
            child: Text(
              "Genesis Packaging",
              style: TextStyle(
                fontSize: 20.sp,
                fontFamily: GoogleFonts.playfairDisplay().fontFamily,
                fontWeight: FontWeight.bold,
                color: HexColor('#a24857'),
              ),
            ),
          ),
          // SizedBox(height: 20),
          // AuthCard(),
          Spacer(),
          Text(
            ' Login to continue',
            style: TextStyle(fontSize: 13.sp),
          ),
          SizedBox(height: 10),
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
          Text('or'),
          GoogleSingupButtonWidget(),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutUs())),
                child: Text(
                  'About us',
                  style: TextStyle(
                    color: Colors.brown,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                height: 3.h,
                width: 1,
                color: Colors.brown,
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Location',
                  style: TextStyle(
                    color: Colors.brown,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }
}
