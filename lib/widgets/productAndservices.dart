import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

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
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: 40.h,
            padding: const EdgeInsets.only(bottom: 8),
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
                      width: 20.h,
                      height: 20.h,
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
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
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
                        'Inquire Directly with the Supplier',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
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
