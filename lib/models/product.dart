import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String? id;
  final String? title;
  final double? size;
  final String? type;
  final double? quantity;
  final String? color;
  final String? supplier;
  final String? dateTime;
  final double? rate;
  final String? gstNo;
  final String imageUrl;

  Product({
    required this.id,
    required this.title,
    required this.size,
    required this.type,
    required this.quantity,
    required this.color,
    required this.supplier,
    required this.dateTime,
    required this.rate,
    required this.gstNo,
    this.imageUrl =
        'https://www.distributioninternational.com/ASSETS/IMAGES/ITEMS/DETAIL_PAGE/MISCSTEELDRUM-v1.jpg',
    // required this.imageUrl,
  });
}
