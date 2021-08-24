import 'package:flutter/material.dart';

class SellerProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'About Genesis Packaging :-',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Registered in 2018, Genesis Packaging has made a name for itself in the list of top suppliers of in India. The supplier company is located in Dadra and Nagar Haveli, Dadra and Nagar Haveli and is one of the leading sellers of listed products. \nGenesis Packaging is listed in Trade India\'s list of verified sellers offering supreme quality of etc. Buy in bulk from us for the best quality products and service.',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.black,
              radius: 22,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.work_outline_outlined,
                  color: Colors.red,
                ),
              ),
            ),
            title: Text(
              'BUSINESS TYPE',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              'Manufacturer , Supplier.',
              style: TextStyle(fontSize: 11),
            ),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.black,
              radius: 22,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.paid,
                  color: Colors.red,
                ),
              ),
            ),
            title: Text(
              'WORKING DAYS',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              'Monday To Sunday',
              style: TextStyle(fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }
}
