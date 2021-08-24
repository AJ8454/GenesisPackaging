import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

class ConnectionError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'OOPS! \n NO INTERNET',
        style: TextStyle(
          fontSize: 15,
          color: Theme.of(context).errorColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        'Please turn on the internet connection.',
        style: TextStyle(
          fontSize: 10,
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
                  fontSize: 14,
                  color: HexColor('#1A2028'),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 20),
          ],
        )
      ],
    );
  }
}
