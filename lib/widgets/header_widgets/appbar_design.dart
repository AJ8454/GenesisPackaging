import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppBarDesign extends StatelessWidget {
  final String? text;
  final IconData? icon;

  const AppBarDesign({
    Key? key,
    required this.text,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(icon),
            ),
            Text(
              text!,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
