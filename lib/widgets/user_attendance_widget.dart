import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../widgets/user_employee_data.dart';
import 'package:provider/provider.dart';
import '../../providers/employeeProvider.dart';

class UserAttendanceWidget extends StatelessWidget {
  Future<void> _refreshEmployee(context) async {
    try {
      await Provider.of<EmployeeProvider>(context, listen: false)
          .fetchAndSetEmployee();
    } catch (error) {
      Fluttertoast.showToast(
        msg: 'No Record Found',
        fontSize: 15.sp,
        backgroundColor: HexColor('#E2E0DF'),
        textColor: Theme.of(context).errorColor,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _refreshEmployee(context),
      builder: (ctx, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<EmployeeProvider>(
                  builder: (ctx, employeeData, _) => ListView.builder(
                    itemCount: employeeData.worker.length,
                    itemBuilder: (_, i) => Column(
                      children: [
                        UserEmployeeData(
                          id: employeeData.worker[i].id!,
                          name: employeeData.worker[i].name!,
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}
