import 'dart:convert';
import '../models/product.dart';
import '../models/http_exception.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ProductsProvider with ChangeNotifier {
  // final String? authToken;
  // final String? userId;

// setter
  List<Product> _items = [];

// getter
  List<Product> get items {
    return [..._items];
  }

  Product findById(String? id) {
    return _items.firstWhere((prod) => prod.id! == id!);
  }

  Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
    var url =
        'https://genesispackaging-a093d-default-rtdb.firebaseio.com/products.json';
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
          id: prodId,
          title: prodData['title'],
          size: prodData['size'],
          type: prodData['type'],
          color: prodData['color'],
          dateTime: prodData['dateTime'],
          gstNo: prodData['gstNo'],
          quantity: prodData['quantity'],
          rate: prodData['rate'],
          supplier: prodData['supplier'],
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addProduct(Product product) async {
    var url =
        'https://genesispackaging-a093d-default-rtdb.firebaseio.com/products.json';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({
          'size': product.size,
          'title': product.title,
          'type': product.type,
          'color': product.color,
          'dateTime': product.dateTime,
          'quantity': product.quantity,
          'gstNo': product.gstNo,
          // 'imageUrl': '',
          'rate': product.rate,
          'supplier': product.supplier,
        }),
      );
      final newProduct = Product(
        id: json.decode(response.body)['name'],
        size: product.size,
        title: product.title,
        type: product.type,
        color: product.color,
        dateTime: product.dateTime,
        quantity: product.quantity,
        gstNo: product.gstNo,
        // imageUrl: '',
        rate: product.rate,
        supplier: product.supplier,
      );
      print('added ${product.title}');
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      print('error deko!$error');
      throw error;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final productIndex = _items.indexWhere((prod) => prod.id == id);
    if (productIndex >= 0) {
      final url =
          'https://genesispackaging-a093d-default-rtdb.firebaseio.com/products/$id.json';
      await http.patch(Uri.parse(url),
          body: json.encode({
            'size': newProduct.size,
            'title': newProduct.title,
            'type': newProduct.type,
            'color': newProduct.color,
            'dateTime': newProduct.dateTime,
            'quantity': newProduct.quantity,
            'gstNo': newProduct.gstNo,
            // 'imageUrl': '',
            'rate': newProduct.rate,
            'supplier': newProduct.supplier,
          }));
      _items[productIndex] = newProduct;
      notifyListeners();
    } else {
      print('..error..');
    }
  }

  Future<void> deleteProduct(String id) async {
    final url =
        'https://genesispackaging-a093d-default-rtdb.firebaseio.com/products/$id.json';
    final exsistingProductIndex = _items.indexWhere((prod) => prod.id == id);
    dynamic exsistingProduct = _items[exsistingProductIndex];
    _items.removeAt(exsistingProductIndex);
    notifyListeners();
    // _items.removeWhere((prod) => prod.id == id);
    final response = await http.delete(Uri.parse(url));
    if (response.statusCode >= 400) {
      _items.insert(exsistingProductIndex, exsistingProduct);
      notifyListeners();
      throw HttpException(message: 'Could not delete product.');
    }
    exsistingProduct = null;
  }
}
