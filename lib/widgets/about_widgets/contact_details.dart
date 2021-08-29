import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ContactDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Text(
          'SUPPLIER CONTACT DETAILS',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        Divider(
          color: Colors.black,
          indent: 40,
          endIndent: 40,
        ),
        SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    width: 80.w,
                    height: 40,
                    padding: EdgeInsets.all(10),
                    color: Colors.red,
                    child: Text(
                      'Genesis Packaging',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  ListView(
                    shrinkWrap: true,
                    children: [
                      ListTile(
                        leading: Icon(Icons.person),
                        title: Text(
                          'Ms. Leela John',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.phone),
                        title: Text(
                          '9324740373 / 9099357217',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.location_on),
                        title: Text(
                          'Plot No. D-33&35, Span Industrial Estate, Opp.Dadra Police Station, Dadra and Nagar Haveli, 396193, India',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
