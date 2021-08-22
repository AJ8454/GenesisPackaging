import '../models/salaryReportFields.dart';
import 'package:gsheets/gsheets.dart';

class EmployeeSalaryReportApi {
  static const _credentials = r'''
  {
  "type": "service_account",
  "project_id": "genesispackaging-2329e",
  "private_key_id": "2cfe17f20e630474bea3733b7fe32e77201e3372",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDuiTnDwMlP0SWN\n0TCVGZRuRCDPw2Az8In9AbHyvG/Xzvk7wcPxH3YkI7r/3P3bbrD1RoUZEPnZgOFg\nkB4fJlqLU931Cu+ZqvR0ghThSxGu1zkUPZfjTVxdHDTO+SHTC7T0tjPQXuwnW3lg\nIr+U4BTdL2sfoy0o3Yxu2XWckGgl7IJuEh6fVLvaL9AI6xDuFpOf8Ch233JULWNz\n5HVsV2AHUyVF3xESoGe1rNbJrbgeqPDwTg/zCguGqb2l05wJPlyuMmdgNy+NtCgY\nIdp+KA7lZc08ERlRGmfFQ5MIrFC5FTpr1DTWCAc19l6a5Jz4p9OyJDhoNs9X0vKg\nLTtNwZxJAgMBAAECggEAap1TADduwwoL6vMQ79NbEF3K/JGqsgxU4IydaIzowGB1\n7UuRtHgHaee+cRXpMOasmTRH0QhRY/HCylIf5HRUC+oUTq3woZJTaK+rfXb8FFWF\n4ZIWDTZKjiNJRyj7AUU+QBIf3oZOrtiny1w8nOH68VF8Y8ufJ6C+X906QBwbMLdE\nLf3gAyDP5NXPirlChcvKH/3ojJMI8ktML8kWJi40f/LsI3E1xuVY74Y1F5coIdUS\ngrfWG5ijCiXxBD3HDqSdEEJOB0UzYEzUQS+il8CIUmB7mc8nihiZ2NUiFRFDBBuN\nnXQuvf2KceBHDlFN2GthdMe6xq2Rtdr044eWuaoqcQKBgQD9IBtC1KliiVDUdGm+\nQvIGz2FIdIR6bZ4U7HrvJqpaLyB2q+mzx6tHCBQgLzjAxR0iHpvyrJwto+2PLNSk\n6nWWy6vfthtt/1dNvgJ/w0XEcDdXvGeVpcBrbrIbbw3ioR0SHjUQcsZpSjnEiyus\nQKMhnJ0elp93BIPwiBprHBx/3wKBgQDxPrRZqv1nmXbxgeZ7Q2+kKzRu3L5pXSLq\nCB4jK/GEjLpayRsBAHgMUyG+oMg9SvU9QR9aG4vWhSScA1YxSYqMuGf9xmV+vNIQ\nPX4X7hIUCYCy3ZI4ZKEpUSiaA8sJQwP+RkPCYWarPr0wHWxGdOM5XxrNw2UkNSI8\nzWX1n5TI1wKBgQDjnlyFU2DiN+LUub5hFig4EYJEumprAWm3HRRLO/TSVjCWJm9o\neDPAEzat3mjliBtzlBzeM3PZ4uB78G9jwWZubMYozMSLvKKQST5MD5gMVnCd19E6\nE6wdr5Q/8TSGSCUxJrLHEL707YdXA2MJabKIRiJP4FiTmR7gTDOdf9Ds9wKBgDyo\nBXSeN4S641spzCel9wYSDubo/b9EOakaTWmOfPVU5O46rl18HrMKm+twRaiTlkHG\ng/mF/4z6gQ/xDtTpprpnC06VeaN6Gl8W9wNRSp5bHU7bww4GzzayP0EqPvyfKvvd\n8t+G2eeoqKzWWQkGDrO4I+ckf+OwsGEVS9OMQj6VAoGAabGR9B4YIJYuzU12sGgB\nFFio8YD4oC1uimtO3IufjJ1pckLb3sdRuiNLLRC4v5ZJvRuXC+omvPEFVDHdTkk2\nHwsJ3FZXjUmUFoZE6cGlZOkwENw0iwZBrhfC0YlHUmlx+/TBjUztLD+QFWh7wW6K\nhRpZZ7eXIG/3LtHb4oJpurw=\n-----END PRIVATE KEY-----\n",
  "client_email": "genesispackaging-2329e@appspot.gserviceaccount.com",
  "client_id": "106635592912984067499",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/genesispackaging-2329e%40appspot.gserviceaccount.com"
}
  ''';
  static final _spreadsheetId = '13n2NB-qrHTBZN-voLUrkdAvHe-zYwBXhdcfLuytx2-8';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _userSheet;

  static Future init() async {
    try {
      final spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
      _userSheet = await _getWorkSheet(spreadsheet, title: 'Sheet1');
      final attributes = SalaryReportFields.getFields();
      _userSheet!.values.insertRow(1, attributes);
    } catch (e) {
      print('error in initSheet $e');
    }
  }

  static Future<Worksheet> _getWorkSheet(
    Spreadsheet spreadsheet, {
    required String title,
  }) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future insert(List<Map<String, dynamic>> rowList) async {
    if (_userSheet == null) return;
    try {
      _userSheet!.values.map.appendRows(rowList);
    } catch (e) {
      print('error in insert $e');
    }
  }

  static Future<int> getRowCount() async {
    if (_userSheet == null) return 0;
    final lastRow = await _userSheet!.values.lastRow();
    return lastRow == null ? 0 : int.tryParse(lastRow.first) ?? 0;
  }
}
