import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../models/product.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../providers/cartProvider.dart';
import '../../providers/productsProvider.dart';

class ProductDetailScreen extends StatefulWidget {
  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedData = Provider.of<ProductsProvider>(context, listen: false)
        .findById(productId);
    final cart = Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              Container(
                height: 20.h,
                width: 40.h,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 26.0,
                    )
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Hero(
                  tag: Key(loadedData.id!),
                  child: Image.network(
                    loadedData.imageUrl,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                loadedData.title!,
                style: TextStyle(
                  fontSize: 22.sp,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              itemDetails('Rate : ', '\u{20B9} ${loadedData.rate}'),
              SizedBox(height: 15),
              itemDetails('Color : ', loadedData.color!),
              SizedBox(height: 15),
              itemDetails('Type : ', loadedData.type!),
              SizedBox(height: 15),
              itemDetails(
                  'Quantity : ',
                  loadedData.quantity == 0
                      ? "Out of Stock"
                      : loadedData.quantity.toString()),
              SizedBox(height: 15),
              itemDetails('Supplier : ', loadedData.supplier!),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 15.h,
        child: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Ink(
                decoration: const ShapeDecoration(
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.red[900],
                  ),
                  iconSize: 30,
                  onPressed: () {
                    cart.addItem(productId, loadedData.rate!, loadedData.title!,
                        loadedData.imageUrl);
                    Provider.of<ProductsProvider>(context, listen: false)
                        .updateProduct(
                            productId,
                            Product(
                              id: productId,
                              size: loadedData.size,
                              title: loadedData.title,
                              type: loadedData.type,
                              color: loadedData.color,
                              dateTime: loadedData.dateTime,
                              quantity: loadedData.quantity! - 1,
                              gstNo: loadedData.gstNo,
                              rate: loadedData.rate,
                              supplier: loadedData.supplier,
                            ))
                        .then((_) => setState(() {
                              Fluttertoast.showToast(
                                msg: '${loadedData.title!} added to cart',
                                fontSize: 18.sp,
                                backgroundColor: Colors.lightGreen.shade300,
                                textColor: Colors.black,
                              );
                            }));
                  },
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 8,
                  padding: EdgeInsets.symmetric(horizontal: 30),
                ),
                onPressed: () {},
                child: Text(
                  'Supply',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemDetails(String attribute, String value) {
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Row(
        children: [
          Text(
            attribute,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
