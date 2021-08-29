import 'dart:convert';
import 'package:intl/intl.dart';
import '../models/attendance.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class EmployeeAttendanceProvider with ChangeNotifier {
 
  DateTime? cDate = DateTime.now();
  String? setCurrentDate() {
    return DateFormat('dd-MM-yyyy').format(cDate!);
  }

// setter
  List<Attendance> _attStatus = [];

// getter
  List<Attendance> get worker {
    return [..._attStatus];
  }

  Attendance findById(String? id) {
    return _attStatus.firstWhere((prod) => prod.id! == id!);
  }

  Future<void> fetchAndSetEmployee(String? currentDate) async {
    var url =
        'https://genesispackaging-a093d-default-rtdb.firebaseio.com/attendance/$currentDate.json';
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Attendance> loadedEmployee = [];
      extractedData.forEach((empId, empData) {
        loadedEmployee.add(
          Attendance(
            id: empId,
            name: empData['name'],
            status: empData['status'],
          ),
        );
      });
      _attStatus = loadedEmployee;
      notifyListeners();
    } catch (error) {
      print('yaha tha re = $error');
      throw error;
    }
  }

  Future<void> addEmployeeAttendance(Attendance empAttendacne) async {
    print('date = ${setCurrentDate()}');
    var url =
        'https://genesispackaging-a093d-default-rtdb.firebaseio.com/attendance/${setCurrentDate()}.json';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({
          'name': empAttendacne.name,
          'status': empAttendacne.status,
        }),
      );
      final newEmpAttendancee = Attendance(
        id: json.decode(response.body)['name'],
        name: empAttendacne.name,
        status: empAttendacne.status,
      );
      _attStatus.add(newEmpAttendancee);
      print('Status done ${empAttendacne.name}');
      notifyListeners();
    } catch (error) {
      print('error deko!$error');
      throw error;
    }
  }

  // Future<void> updateEmployee(String id, Employee newEmployee) async {
  //   final employeeIndex = _workers.indexWhere((emp) => emp.id == id);
  //   if (employeeIndex >= 0) {
  //     final url =
  //         'https://genesispackaging-a093d-default-rtdb.firebaseio.com/employees/$id.json';
  //     await http.patch(Uri.parse(url),
  //         body: json.encode({
  //           'name': newEmployee.name,
  //           'gender': newEmployee.gender,
  //           'startTime': newEmployee.startTime,
  //           'endTime': newEmployee.endTime,
  //           'wages': newEmployee.wages,
  //           'dateTime': newEmployee.dateTime,
  //           'overTime': newEmployee.overTime,
  //         }));
  //     _workers[employeeIndex] = newEmployee;
  //     notifyListeners();
  //   } else {
  //     print('..error..');
  //   }
  // }

  // Future<void> deleteEmployee(String id) async {
  //   final url =
  //       'https://genesispackaging-a093d-default-rtdb.firebaseio.com/employees/$id.json';
  //   final exsistingEmployeeIndex = _workers.indexWhere((emp) => emp.id == id);
  //   dynamic exsistingEmployee = _workers[exsistingEmployeeIndex];
  //   _workers.removeAt(exsistingEmployeeIndex);
  //   notifyListeners();
  //   // _items.removeWhere((prod) => prod.id == id);
  //   final response = await http.delete(Uri.parse(url));
  //   if (response.statusCode >= 400) {
  //     _workers.insert(exsistingEmployeeIndex, exsistingEmployee);
  //     notifyListeners();
  //     throw HttpException(message: 'Could not delete product.');
  //   }
  //   exsistingEmployee = null;
  // }
}
