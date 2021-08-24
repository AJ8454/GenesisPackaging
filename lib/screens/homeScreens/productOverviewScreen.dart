import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../widgets/nameTitle.dart';
import '../../screens/homeScreens/home_screen.dart';
import '../../providers/cartProvider.dart';
import '../../widgets/user_attendance_widget.dart';
import '../../widgets/badge.dart';
import '../../screens/homeScreens/dashbord_screen.dart';
import '../../widgets/app_drawer.dart';

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  int currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final screens = [
    HomeScreen(),
    DashBord(),
    UserAttendanceWidget(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        child: SafeArea(
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => _scaffoldKey.currentState!.openDrawer(),
                  icon: Icon(
                    Icons.menu,
                    color: HexColor('#922A31'),
                  ),
                ),
                const NameTitle(),
                Consumer<CartProvider>(
                  builder: (_, cart, ch) => Badge(
                    child: ch!,
                    value: cart.itemCount.toString(),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.shopping_cart_rounded,
                      size: 25,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/cart');
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        preferredSize: Size.fromHeight(100),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        backgroundColor: HexColor('#697A98'),
        selectedItemColor: HexColor('#F5F5F5'),
        unselectedItemColor: HexColor('#231F1F'),
        iconSize: 20,
        selectedFontSize: 15,
        onTap: (index) => setState(() => currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.tachometerAlt),
            label: 'Dashbord',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.calendarCheck),
            label: 'Attendance',
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: screens[currentIndex],
    );
  }
}
