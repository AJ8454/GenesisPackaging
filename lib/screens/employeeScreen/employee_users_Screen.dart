import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../widgets/header_widgets/appbar_design.dart';
import 'package:provider/provider.dart';
import '../../widgets/employee_widgets/user_employee.dart';
import '../../providers/employeeProvider.dart';
import '../../utils/UserSimplePreferences.dart';

class EmployeeUserScreen extends StatelessWidget {
  final gUserId = UserSimplePreferences.getUserId();
  final eUserId = UserSimplePreferences.getEuserId();
  Future<void> _refreshEmployee(BuildContext context) async {
    try {
      await Provider.of<EmployeeProvider>(context, listen: false)
          .fetchAndSetEmployee();
    } catch (error) {
      Fluttertoast.showToast(
        msg: 'No Employees Added Yet',
        fontSize: 15.sp,
        backgroundColor: HexColor('#E2E0DF'),
        textColor: Theme.of(context).errorColor,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#F3F4F7'),
      appBar: PreferredSize(
        child: AppBarDesign(
          icon: Icons.arrow_back,
          text: 'All Employee',
        ),
        preferredSize: Size.fromHeight(100),
      ),
      body: FutureBuilder(
        future: _refreshEmployee(context),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<EmployeeProvider>(
                    builder: (ctx, employeeData, _) => Padding(
                      padding: EdgeInsets.all(8),
                      child: ListView.builder(
                        itemCount: employeeData.worker.length,
                        itemBuilder: (_, i) => Column(
                          children: [
                            UserEmployee(
                              id: employeeData.worker[i].id!,
                              name: employeeData.worker[i].name!,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/EditEmployeeScreen');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
