import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';

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
            child: Column(
              children: [
                Expanded(child: Container()),
                TabBar(
                  isScrollable: true,
                  unselectedLabelColor: Colors.grey,
                  labelColor: Colors.red,
                  tabs: [
                    tabBarName('Seller Profile'),
                    tabBarName('Products & Services'),
                    tabBarName('Contact Details'),
                  ],
                )
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
        Card(
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
                      fontFamily: GoogleFonts.lora().fontFamily,
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
      ],
    );
  }
}

class ProductAndServices extends StatefulWidget {
  @override
  _ProductAndServicesState createState() => _ProductAndServicesState();
}

class _ProductAndServicesState extends State<ProductAndServices> {
  bool _isChecked = false;
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveState = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveState.contains)) {
      return Colors.blue;
    }
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'For more Products, Login and view under category',
              style: TextStyle(
                fontSize: 15,
                fontFamily: GoogleFonts.lora().fontFamily,
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 270,
            width: 70.w,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image(
                      height: 200,
                      image: AssetImage(
                        'assets/images/stainlessSteelDrum.jpg',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    'Stainless Steel Drum',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: GoogleFonts.lora().fontFamily,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 8),
          Container(
            width: 90.h,
            height: 600,
            padding: EdgeInsets.all(12),
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
                        'Inquire Directly with the Supplier',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: GoogleFonts.lora().fontFamily,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Tell us about your requirement',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Describe in few words*',
                                hintText:
                                    'Please include product name, order quality, usage, special request if any in your inquiry.',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 32.0),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 1.0),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                              maxLines: 3,
                              keyboardType: TextInputType.multiline,
                              onSaved: (value) {},
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a description.';
                                }
                                if (value.length < 5) {
                                  return 'Should be at least 8 characters long.';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 15),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: 'Email ID*',
                                hintText: 'Email Id',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 32.0),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 1.0),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                              textInputAction: TextInputAction.next,
                              onSaved: (value) {},
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a title.';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 15),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Phone number*',
                                hintText: 'Phone number',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 32.0),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 1.0),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                              textInputAction: TextInputAction.next,
                              onSaved: (value) {},
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter Phone number.';
                                } else if (value.length < 10) {
                                  return 'Please enter valid number';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 15),
                            Row(
                              children: [
                                Checkbox(
                                  fillColor: MaterialStateProperty.resolveWith(
                                      getColor),
                                  value: _isChecked,
                                  onChanged: (bool? val) {
                                    setState(() {
                                      _isChecked = val!;
                                    });
                                  },
                                ),
                                Text(
                                  'I agree to term and conditions.',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: Text('Send Inquiry'),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SellerProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'About Genesis Packaging :- \n\nRegistered in 2018, Genesis Packaging has made a name for itself in the list of top suppliers of in India. The supplier company is located in Dadra and Nagar Haveli, Dadra and Nagar Haveli and is one of the leading sellers of listed products. \nGenesis Packaging is listed in Trade India\'s list of verified sellers offering supreme quality of etc. Buy in bulk from us for the best quality products and service.',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(
                'assets/images/briefcase.png',
              ),
            ),
            title: Text(
              'BUSINESS TYPE',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            subtitle: Text('Manufacturer , Supplier.'),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(
                'assets/images/cash.png',
              ),
            ),
            title: Text(
              'WORKING DAYS',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            subtitle: Text('Monday To Sunday'),
          ),
        ],
      ),
    );
  }
}
