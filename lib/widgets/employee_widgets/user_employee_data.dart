import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../models/attendance.dart';
import '../../../providers/employeeAttendance_Provider.dart';

class UserEmployeeData extends StatefulWidget {
  final String? id;
  final String name;

  const UserEmployeeData({
    Key? key,
    required this.id,
    required this.name,
  }) : super(key: key);

  @override
  _UserEmployeeDataState createState() => _UserEmployeeDataState();
}

class _UserEmployeeDataState extends State<UserEmployeeData> {
  List<bool> isSelected = [false, false];

  String? getText() {
    if (isSelected[0] == true) {
      return 'Present';
    } else if (isSelected[1] == true) {
      return 'Absent';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 3.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: BorderSide(
            color: Colors.black,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(
              widget.name,
              style: TextStyle(color: Colors.black, fontSize: 16.sp),
            ),
            leading: CircleAvatar(
              backgroundImage: AssetImage(
                'assets/images/person.png',
              ),
              backgroundColor: Colors.white,
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15),
                  ToggleButtons(
                    borderRadius: BorderRadius.circular(15),
                    selectedColor: Colors.white,
                    isSelected: isSelected,
                    fillColor: isSelected[0] ? Colors.green : Colors.red,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          'Present',
                          style: TextStyle(fontSize: 13.sp),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          'Absent',
                        ),
                      ),
                    ],
                    onPressed: (int newIndex) async {
                      setState(() {
                        for (int index = 0; index < isSelected.length; index++)
                          if (index == newIndex) {
                            isSelected[index] = true;
                          } else {
                            isSelected[index] = false;
                          }
                      });

                      await Provider.of<EmployeeAttendanceProvider>(context,
                              listen: false)
                          .addEmployeeAttendance(
                        Attendance(
                          id: widget.id,
                          name: widget.name,
                          status: getText()!,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
