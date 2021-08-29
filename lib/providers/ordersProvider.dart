import 'dart:convert';
import 'package:flutter/material.dart';
import '../utils/UserSimplePreferences.dart';
import '../models/cart.dart';
import '../models/orders.dart';
import 'package:http/http.dart' as http;

class OrdersProvider with ChangeNotifier {
  List<Orders> _orders = [];

  final String? userId;

  OrdersProvider(
    this.userId,
    this._orders,
  );

  Future<String?> storeUserId() async {
    await UserSimplePreferences.setUserId(userId);
  }

  String? savedUserId = UserSimplePreferences.getUserId() ?? '';

  List<Orders> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final url =
        'https://genesispackaging-a093d-default-rtdb.firebaseio.com/orders/$savedUserId.json';
    try {
      final response = await http.get(Uri.parse(url));
      final List<Orders> loadedOrder = [];
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      extractedData.forEach((orderId, orderData) {
        loadedOrder.add(
          Orders(
            id: orderId,
            amount: orderData['amount'],
            dateTime: DateTime.parse(orderData['dateTime']),
            products: (orderData['products'] as List<dynamic>)
                .map(
                  (item) => CartItem(
                    item['imageUrl'],
                    id: item['id'],
                    price: item['price'],
                    quantity: item['quantity'],
                    title: item['title'],
                  ),
                )
                .toList(),
          ),
        );
      });
      _orders = loadedOrder.reversed.toList();
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url =
        'https://genesispackaging-a093d-default-rtdb.firebaseio.com/orders/$savedUserId.json';
    final timeStamp = DateTime.now();
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({
          'amount': total,
          'dateTime': timeStamp.toIso8601String(),
          'products': cartProducts
              .map((cp) => {
                    'id': cp.id,
                    'title': cp.title,
                    'quantity': cp.quantity,
                    'price': cp.price,
                  })
              .toList(),
        }),
      );
      _orders.insert(
        0,
        Orders(
          id: json.decode(response.body)['name'],
          amount: total,
          dateTime: timeStamp,
          products: cartProducts,
        ),
      );
      notifyListeners();
    } catch (error) {}
  }
}
