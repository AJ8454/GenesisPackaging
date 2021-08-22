import 'package:flutter/material.dart';

class Attendance with ChangeNotifier {
  final String? id;
  final String? name;
  final String? status;

  Attendance({
    required this.id,
    required this.name,
    required this.status,
  });
}
