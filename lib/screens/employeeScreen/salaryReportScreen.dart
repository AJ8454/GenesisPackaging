import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../widgets/appbar_design.dart';
import '../../models/salaryReportFields.dart';
import '../../providers/salaryReport_sheets_api.dart';

class SalaryReprotScreen extends StatefulWidget {
  @override
  _SalaryReprotScreenState createState() => _SalaryReprotScreenState();
}

class _SalaryReprotScreenState extends State<SalaryReprotScreen> {
  late TextEditingController controllerName;
  late TextEditingController controllerTotalSalary;
  late TextEditingController controllerMonth;
  late TextEditingController controllerOverTimeDays;
  late TextEditingController controllerAdvanceTaken;
  late TextEditingController controllerBalanceAmount;

  var _isLoading = false;
  final FocusScopeNode _node = FocusScopeNode();
  final _form = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    initReport();
  }

  void initReport() {
    controllerName = TextEditingController();
    controllerTotalSalary = TextEditingController();
    controllerMonth = TextEditingController();
    controllerOverTimeDays = TextEditingController();
    controllerAdvanceTaken = TextEditingController();
    controllerBalanceAmount = TextEditingController();
  }

  @override
  void dispose() {
    _node.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    try {
      final report = SalaryReport(
        name: controllerName.text,
        totalSalary: double.parse(controllerTotalSalary.text),
        month: int.parse(controllerMonth.text),
        overtimeDays: int.parse(controllerOverTimeDays.text),
        advanceTaken: double.parse(controllerAdvanceTaken.text),
        balanceAmount: double.parse(controllerBalanceAmount.text),
      );
      final int? id = await EmployeeSalaryReportApi.getRowCount() + 1;
      final newReport = report.copy(id: id);
      await EmployeeSalaryReportApi.insert([newReport.toJson()]).then(
        (_) => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Salary Report Saved.',
              style: TextStyle(fontSize: 20),
            ),
            backgroundColor: Colors.green,
          ),
        ),
      );
    } catch (e) {
      print(e);
      await showDialog<Null>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An Error occured!'),
          content: Text('Something went wrong.'),
          actions: [
            TextButton(
              child: Text('Okay', style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#F3F4F7'),
      appBar: PreferredSize(
        child: AppBarDesign(
          icon: Icons.arrow_back,
          text: 'Salary Report',
        ),
        preferredSize: Size.fromHeight(100),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: FocusScope(
                  node: _node,
                  child: Form(
                    key: _form,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: controllerName,
                          decoration: InputDecoration(labelText: 'Full Name'),
                          textInputAction: TextInputAction.next,
                          onEditingComplete: _node.nextFocus,
                          onSaved: (value) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a Name.';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: controllerTotalSalary,
                          decoration:
                              InputDecoration(labelText: 'Total Salary'),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          onEditingComplete: _node.nextFocus,
                          onSaved: (value) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a Total Salary.';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: controllerMonth,
                          decoration: InputDecoration(labelText: 'Month'),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          onEditingComplete: _node.nextFocus,
                          onSaved: (value) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a Month.';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: controllerOverTimeDays,
                          decoration:
                              InputDecoration(labelText: 'OverTime Days'),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          onEditingComplete: _node.nextFocus,
                          onSaved: (value) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a OverTime Days.';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: controllerAdvanceTaken,
                          decoration:
                              InputDecoration(labelText: 'Advance Taken'),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          onEditingComplete: _node.nextFocus,
                          onSaved: (value) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a Advance Taken.';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: controllerBalanceAmount,
                          decoration:
                              InputDecoration(labelText: 'Balance Amount'),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          onEditingComplete: _node.nextFocus,
                          onSaved: (value) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a Balance Amount.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.amber,
                            elevation: 8,
                            padding: EdgeInsets.symmetric(horizontal: 50),
                          ),
                          onPressed: () => _submitForm(),
                          child: Text(
                            'Save',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey[800],
                            ),
                          ),
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