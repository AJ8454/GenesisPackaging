import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class EmployeeProfileScreen extends StatelessWidget {
  const EmployeeProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#F3F4F7'),
      appBar: PreferredSize(
        child: SafeArea(
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back),
                ),
                SizedBox(width: 20),
                Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
        preferredSize: Size.fromHeight(100),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Employee Profile'),
          ],
        ),
      ),
    );
  }
}
