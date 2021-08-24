import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../widgets/contact_details.dart';
import '../widgets/productAndservices.dart';
import '../widgets/sellerProfile.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    Widget tabBarName(String name) {
      return Text(
        name,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
        ),
      );
    }

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: SafeArea(
            child: TabBar(
              isScrollable: true,
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.black,
              tabs: [
                tabBarName('Seller Profile'),
                tabBarName('Products & Services'),
                tabBarName('Contact Details'),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            SellerProfile(),
            ProductAndServices(),
            ContactDetails(),
          ],
        ),
      ),
    );
  }
}
