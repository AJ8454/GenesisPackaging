import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../widgets/header_widgets/appbar_design.dart';
import '../../providers/employeeProvider.dart';
import '../../models/employee.dart';

class EditEmployeeScreen extends StatefulWidget {
  const EditEmployeeScreen({Key? key}) : super(key: key);

  @override
  _EditEmployeeScreenState createState() => _EditEmployeeScreenState();
}

class _EditEmployeeScreenState extends State<EditEmployeeScreen> {
  static final List<String> gender = [
    'Select',
    'Male',
    'Female',
    'Other',
  ];
  String value = gender.first;

  var _isInit = true;
  var _isLoading = false;
  final FocusScopeNode _node = FocusScopeNode();
  final _form = GlobalKey<FormState>();
  var _editEmployee = Employee(
    id: null,
    name: '',
    gender: '',
    startTime: '',
    endTime: '',
    dateTime: '',
    wages: 0.0,
    overTime: '',
  );

  var _initValues = {
    'name': '',
    'gender': '',
    'startTime': '',
    'endTime': '',
    'wages': '',
    'dateTime': '',
    'overTime': '',
  };

  TimeOfDay? time;
  String getStartTimeText() {
    if (time == null) {
      return 'Select Time';
    } else {
      final hours = time!.hour.toString().padLeft(2, '0');
      final minutes = time!.minute.toString().padLeft(2, '0');
      return '$hours : $minutes';
    }
  }

  TimeOfDay? endTime;
  String getEndTimeText() {
    if (endTime == null) {
      return 'Select Time';
    } else {
      final endhours = endTime!.hour.toString().padLeft(2, '0');
      final endminutes = endTime!.minute.toString().padLeft(2, '0');

      return '$endhours : $endminutes';
    }
  }

  TimeOfDay? fromTime;
  String getFromTimeText() {
    if (fromTime == null) {
      return 'NA';
    } else {
      final fromhours = fromTime!.hour.toString().padLeft(2, '0');
      final fromminutes = fromTime!.minute.toString().padLeft(2, '0');
      return '$fromhours : $fromminutes';
    }
  }

  TimeOfDay? toTime;
  String getToTimeText() {
    if (toTime == null) {
      return 'NA';
    } else {
      final tohours = toTime!.hour.toString().padLeft(2, '0');
      final tominutes = toTime!.minute.toString().padLeft(2, '0');
      return '$tohours : $tominutes';
    }
  }

  DateTime? date;
  String getDateText() {
    if (date == null) {
      return 'Select Date';
    } else {
      return DateFormat('dd/MM/yyyy').format(date!);
    }
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final employeeId = ModalRoute.of(context)!.settings.arguments;
      if (employeeId != null) {
        _editEmployee = Provider.of<EmployeeProvider>(context, listen: false)
            .findById(employeeId.toString());
        _initValues = {
          'name': _editEmployee.name.toString(),
          'startTime': _editEmployee.startTime.toString(),
          'endTime': _editEmployee.endTime.toString(),
          'wages': _editEmployee.wages.toString(),
          'dateTime': _editEmployee.dateTime.toString(),
          'overTime': _editEmployee.overTime.toString(),
        };
      }
    }
    _isInit = false;
    super.didChangeDependencies();
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

    if (_editEmployee.id != null) {
      await Provider.of<EmployeeProvider>(context, listen: false)
          .updateEmployee(_editEmployee.id!, _editEmployee)
          .then(
            (_) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Employee Updated.',
                  style: TextStyle(fontSize: 20),
                ),
                backgroundColor: Colors.orange[400],
              ),
            ),
          );
    } else {
      try {
        await Provider.of<EmployeeProvider>(context, listen: false)
            .addEmployee(_editEmployee)
            .then(
              (_) => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Employee Saved.',
                    style: TextStyle(fontSize: 20),
                  ),
                  backgroundColor: Colors.green,
                ),
              ),
            );
      } catch (e) {
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
          text: 'Edit Employee',
          icon: Icons.arrow_back,
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
                          initialValue: _initValues['name'],
                          decoration: InputDecoration(labelText: 'Name'),
                          textInputAction: TextInputAction.next,
                          onEditingComplete: _node.nextFocus,
                          onSaved: (value) {
                            _editEmployee = Employee(
                              name: value!,
                              id: _editEmployee.id,
                              gender: _editEmployee.gender,
                              startTime: _editEmployee.startTime,
                              endTime: _editEmployee.endTime,
                              dateTime: _editEmployee.dateTime,
                              wages: _editEmployee.wages,
                              overTime: _editEmployee.overTime,
                            );
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a name.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 32),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Gender :',
                              style: TextStyle(
                                  fontSize: 12.sp, color: Colors.black),
                            ),
                            const SizedBox(width: 32),
                            buildDrowdown(),
                          ],
                        ),
                        const SizedBox(height: 32),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Start Time :',
                              style: TextStyle(
                                  fontSize: 12.sp, color: Colors.black),
                            ),
                            const SizedBox(width: 32),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 8,
                                padding: EdgeInsets.symmetric(horizontal: 24),
                              ),
                              child: Text(
                                getStartTimeText(),
                                style: TextStyle(
                                  fontSize: 9.sp,
                                ),
                              ),
                              onPressed: () => pickStartTime(context),
                            )
                          ],
                        ),
                        const SizedBox(height: 32),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'End Time :',
                              style: TextStyle(
                                  fontSize: 12.sp, color: Colors.black),
                            ),
                            const SizedBox(width: 32),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 8,
                                padding: EdgeInsets.symmetric(horizontal: 24),
                              ),
                              child: Text(
                                getEndTimeText(),
                                style: TextStyle(
                                  fontSize: 9.sp,
                                ),
                              ),
                              onPressed: () => pickEndTime(context),
                            )
                          ],
                        ),
                        TextFormField(
                          initialValue: _initValues['wages'],
                          decoration: InputDecoration(labelText: 'Wages'),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          onEditingComplete: _node.nextFocus,
                          onSaved: (value) {
                            _editEmployee = Employee(
                              name: _editEmployee.name,
                              gender: _editEmployee.gender,
                              id: _editEmployee.id,
                              startTime: _editEmployee.startTime,
                              endTime: _editEmployee.endTime,
                              dateTime: _editEmployee.dateTime,
                              wages: double.parse(value!),
                              overTime: _editEmployee.overTime,
                            );
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a wages.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 32),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Over Time :',
                              style: TextStyle(
                                  fontSize: 12.sp, color: Colors.black),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              children: [
                                Text(
                                  'From',
                                  style: TextStyle(
                                    fontSize: 9.sp,
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.deepPurple,
                                    elevation: 8,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 24),
                                  ),
                                  child: Text(
                                    getFromTimeText(),
                                    // getEndTimeText(),
                                    style: TextStyle(
                                      fontSize: 9.sp,
                                    ),
                                  ),
                                  onPressed: () => pickFromTime(context),
                                ),
                              ],
                            ),
                            const SizedBox(width: 8),
                            Column(
                              children: [
                                Text(
                                  'To',
                                  style: TextStyle(
                                    fontSize: 9.sp,
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.deepPurple,
                                    elevation: 8,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 24),
                                  ),
                                  child: Text(
                                    getToTimeText(),
                                    // getEndTimeText(),
                                    style: TextStyle(
                                      fontSize: 9.sp,
                                    ),
                                  ),
                                  onPressed: () => pickToTime(context),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Date :',
                              style: TextStyle(
                                  fontSize: 12.sp, color: Colors.black),
                            ),
                            const SizedBox(width: 32),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 8,
                                padding: EdgeInsets.symmetric(horizontal: 24),
                              ),
                              child: Text(
                                getDateText(),
                                style: TextStyle(
                                  fontSize: 9.sp,
                                ),
                              ),
                              onPressed: () => pickDate(context),
                            )
                          ],
                        ),
                        const SizedBox(height: 45),
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

  Widget buildDrowdown() {
    return Container(
      width: 45.w,
      height: 30,
      padding: EdgeInsets.only(left: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(),
        color: Colors.white30,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          items: gender
              .map(
                (sex) => DropdownMenuItem<String>(
                  child: Text(
                    sex,
                    style: TextStyle(
                      fontSize: 10.sp,
                    ),
                  ),
                  value: sex,
                ),
              )
              .toList(),
          onChanged: (value) => setState(() {
            this.value = value!;
            _editEmployee = Employee(
              name: _editEmployee.name,
              gender: value,
              id: _editEmployee.id,
              startTime: _editEmployee.startTime,
              endTime: _editEmployee.endTime,
              dateTime: _editEmployee.dateTime,
              wages: _editEmployee.wages,
              overTime: _editEmployee.overTime,
            );
          }),
        ),
      ),
    );
  }

  Future pickStartTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: time ?? initialTime,
    );
    if (newTime == null) return;
    setState(() => time = newTime);
    print('Stime =' + getStartTimeText());
    _editEmployee = Employee(
      name: _editEmployee.name,
      gender: _editEmployee.gender,
      id: _editEmployee.id,
      startTime: getStartTimeText().toString(),
      endTime: _editEmployee.endTime,
      dateTime: _editEmployee.dateTime,
      wages: _editEmployee.wages,
      overTime: _editEmployee.overTime,
    );
  }

  Future pickEndTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newendTime = await showTimePicker(
      context: context,
      initialTime: endTime ?? initialTime,
    );
    if (newendTime == null) return;
    setState(() => endTime = newendTime);
    print('Etime = ' + getEndTimeText());
    _editEmployee = Employee(
      name: _editEmployee.name,
      gender: _editEmployee.gender,
      id: _editEmployee.id,
      startTime: _editEmployee.startTime,
      endTime: getEndTimeText().toString(),
      dateTime: _editEmployee.dateTime,
      wages: _editEmployee.wages,
      overTime: _editEmployee.overTime,
    );
  }

  String overTime() {
    return getFromTimeText() + ' To ' + getToTimeText();
  }

  Future pickFromTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newfromTime = await showTimePicker(
      context: context,
      initialTime: fromTime ?? initialTime,
    );
    if (newfromTime == null) return;
    setState(() => fromTime = newfromTime);
    print('Ftime = ' + getFromTimeText());
  }

  Future pickToTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newToTime = await showTimePicker(
      context: context,
      initialTime: toTime ?? initialTime,
    );
    if (newToTime == null) return;
    setState(() => toTime = newToTime);
    print('Ftime = ' + getToTimeText());
    print('OverTime = ' + overTime());
    _editEmployee = Employee(
      name: _editEmployee.name,
      gender: _editEmployee.gender,
      id: _editEmployee.id,
      startTime: _editEmployee.startTime,
      endTime: _editEmployee.endTime,
      dateTime: _editEmployee.dateTime,
      wages: _editEmployee.wages,
      overTime: overTime().toString(),
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
    print('date = ' + getDateText());
    _editEmployee = Employee(
      name: _editEmployee.name,
      gender: _editEmployee.gender,
      id: _editEmployee.id,
      startTime: _editEmployee.startTime,
      endTime: _editEmployee.endTime,
      dateTime: getDateText().toString(),
      wages: _editEmployee.wages,
      overTime: _editEmployee.overTime,
    );
  }
}
