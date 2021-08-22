import 'package:flutter/material.dart';
import '../../widgets/user_attendance_widget.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../widgets/appbar_design.dart';

class EmployeeAttendance extends StatefulWidget {
  const EmployeeAttendance({Key? key}) : super(key: key);

  @override
  _EmployeeAttendanceState createState() => _EmployeeAttendanceState();
}

class _EmployeeAttendanceState extends State<EmployeeAttendance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#F3F4F7'),
      appBar: PreferredSize(
        child: AppBarDesign(
          icon: Icons.arrow_back,
          text: 'Attendance',
        ),
        preferredSize: Size.fromHeight(100),
      ),
      body: UserAttendanceWidget(),
    );
  }
}
