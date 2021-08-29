import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import '../../providers/google_sign_in_provider.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      child: Drawer(
        elevation: 8,
        child: Container(
          color: HexColor('#697A98'),
          child: ListView(children: [
            SizedBox(
              height: 60,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: HexColor('#697A98'),
                ),
                child: Text(
                  'Genesis Packaging',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: GoogleFonts.ptSerif().fontFamily,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: HexColor('#F5F5F5'),
                  ),
                ),
              ),
            ),
            DrawerListTile(
              name: 'Stock',
              icon: Icons.production_quantity_limits,
              navigate: '/userProductScreen',
            ),
            DrawerListTile(
              name: 'Employees',
              icon: Icons.person,
              navigate: '/EmployeeScreen',
            ),
            DrawerListTile(
              name: 'Orders',
              icon: Icons.local_shipping_rounded,
              navigate: '/OrdersScreen',
            ),
            DrawerListTile(
              name: 'Production',
              icon: Icons.poll_rounded,
              navigate: '',
            ),
            DrawerListTile(
              name: 'Tasks',
              icon: Icons.task_alt,
              navigate: '',
            ),
            DrawerListTile(
              name: 'Supplier Record',
              icon: Icons.receipt_long_outlined,
              navigate: '',
            ),
            DrawerListTile(
              name: 'Purchase Record',
              icon: Icons.receipt,
              navigate: '',
            ),
            ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color: Colors.white70,
              ),
              title: Text(
                'Logout',
                style: TextStyle(color: HexColor('#F5F5F5'), fontSize: 13),
              ),
              onTap: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.logout();
              },
            ),
          ]),
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  final String? name, navigate;
  final IconData icon;

  DrawerListTile({
    Key? key,
    required this.name,
    required this.navigate,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white70,
      ),
      title: Text(
        name!,
        style: TextStyle(color: HexColor('#F5F5F5'), fontSize: 13),
      ),
      onTap: () {
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed(navigate!);
      },
    );
  }
}
