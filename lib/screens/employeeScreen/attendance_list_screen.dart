import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';
import '../../models/attendance.dart';
import '../../providers/employeeAttendance_Provider.dart';
import '../../widgets/header_widgets/appbar_design.dart';

class AttendanceListScreen extends StatefulWidget {
  @override
  _AttendanceListScreenState createState() => _AttendanceListScreenState();
}

class _AttendanceListScreenState extends State<AttendanceListScreen> {
  String? _message = 'Please select the date to view record';
  Future<void> _refreshAttendanceData(BuildContext context) async {
    try {
      await Provider.of<EmployeeAttendanceProvider>(context, listen: false)
          .fetchAndSetEmployee(getText());
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'No Record Found',
        fontSize: 15.sp,
        backgroundColor: HexColor('#E2E0DF'),
        textColor: Theme.of(context).errorColor,
      );
    }
  }

  DateTime? date;
  String? getText() {
    if (date == null) {
      return 'Select Date';
    } else {
      return DateFormat('dd-MM-yyyy').format(date!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        child: AppBarDesign(
          icon: Icons.arrow_back,
          text: 'Attendance View',
        ),
        preferredSize: Size.fromHeight(100),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Date :',
                style: TextStyle(fontSize: 12.sp, color: Colors.black),
              ),
              const SizedBox(width: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 8,
                  padding: EdgeInsets.symmetric(horizontal: 18),
                ),
                child: Text(
                  getText()!,
                  style: TextStyle(
                    fontSize: 12.sp,
                  ),
                ),
                onPressed: () => pickDate(context),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: buildBuildDataTable(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget? buildBuildDataTable(BuildContext context) {
    final columns = ['Name', 'Status'];
    return getText() == 'Select Date'
        ? Center(
            child: Text(_message!),
          )
        : FutureBuilder(
            future: _refreshAttendanceData(context),
            builder: (context, snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Consumer<EmployeeAttendanceProvider>(
                        builder: (ctx, productData, _) => Center(
                          child: DataTable(
                            columns: getColumns(columns),
                            rows: getRows(productData.worker),
                          ),
                        ),
                      ),
          );
  }

  Future pickDate(BuildContext context) async {
    final initalDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: initalDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (newDate == null) return;

    setState(() => date = newDate);
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map((String column) => DataColumn(
              label: Text(
            column,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.brown),
          )))
      .toList();

  List<DataRow> getRows(List<Attendance> user) => user.map((Attendance user) {
        final cells = [user.name, user.status];
        return DataRow(cells: getCells(cells));
      }).toList();

  List<DataCell> getCells(List<dynamic> cells) =>
      cells.map((data) => DataCell(Text('$data'))).toList();
}
