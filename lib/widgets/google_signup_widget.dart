import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../providers/google_sign_in_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GoogleSingupButtonWidget extends StatelessWidget {
  const GoogleSingupButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: BorderSide(
              color: HexColor('#374A5A'),
            )),
        elevation: 8,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
      label: Text(
        'Sign in with Google',
        style: TextStyle(
            color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 12.sp),
      ),
      icon: FaIcon(FontAwesomeIcons.google, color: Colors.red),
      onPressed: () {
        final provider =
            Provider.of<GoogleSignInProvider>(context, listen: false);
        provider.login();
      },
    );
  }
}
