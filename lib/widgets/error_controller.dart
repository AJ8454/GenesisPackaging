import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ErrorController extends StatelessWidget {
  final String? errorTitle;
  final String? errorDesc;

  ErrorController({
    Key? key,
    required this.errorTitle,
    required this.errorDesc,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            errorTitle!,
            style: TextStyle(
              fontSize: 12.sp,
              color: Theme.of(context).errorColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            errorDesc!,
            style: TextStyle(
              fontSize: 10.sp,
              color: Colors.black45,
            ),
          ),
        ],
      ),
    );
  }
}
