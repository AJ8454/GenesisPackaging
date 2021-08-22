import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../widgets/appbar_design.dart';
import 'package:sizer/sizer.dart';

class EmployeeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#F3F4F7'),
      appBar: PreferredSize(
        child: AppBarDesign(
          icon: Icons.arrow_back,
          text: 'Employees',
        ),
        preferredSize: Size.fromHeight(100),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BuildEmployeeOperation(
              bttnName: 'Add Employee',
              navigate: '/EmployeeUserScreen',
              bttnIcon: Icons.person,
            ),
            const SizedBox(height: 20),
            BuildEmployeeOperation(
              bttnName: 'Attendance View',
              navigate: '/AttendanceListScreen',
              bttnIcon: Icons.perm_contact_calendar_rounded,
            ),
            const SizedBox(height: 20),
            BuildEmployeeOperation(
              bttnName: 'Salary Report',
              navigate: '/SalaryReprotScreen',
              bttnIcon: Icons.money,
            ),
          ],
        ),
      ),
    );
  }
}

class BuildEmployeeOperation extends StatelessWidget {
  final String? navigate, bttnName;
  final IconData? bttnIcon;
  BuildEmployeeOperation({
    Key? key,
    required this.bttnName,
    required this.navigate,
    required this.bttnIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 7.0,
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      child: InkWell(
        onTap: () => Navigator.of(context).pushNamed(navigate!),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.amber.shade200, Colors.yellow.shade300]),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          height: 8.h,
          width: 70.w,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    bttnName!,
                    style: TextStyle(
                      color: Colors.grey[800],
                    ),
                  ),
                ),
              ),
              Icon(bttnIcon!, color: Colors.grey[800], size: 20.0),
              SizedBox(width: 20),
            ],
          ),
        ),
      ),
    );
  }
}
