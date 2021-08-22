import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../../providers/productsProvider.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../providers/cartProvider.dart';

class CartItemView extends StatelessWidget {
  final String? id;
  final String productId;
  final double price;
  final int quantity;
  final String? imageUrl;
  final String title;

  const CartItemView({
    Key? key,
    required this.id,
    required this.price,
    required this.quantity,
    required this.title,
    required this.productId,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);
    final product = Provider.of<ProductsProvider>(context, listen: false)
        .findById(productId);
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to remove item from the cart?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
                child: Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('items removed!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: Text('Yes'),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        Provider.of<ProductsProvider>(context, listen: false)
            .updateProduct(
                productId,
                Product(
                  id: productId,
                  size: product.size,
                  title: product.title,
                  type: product.type,
                  color: product.color,
                  dateTime: product.dateTime,
                  quantity: product.quantity! + 1,
                  gstNo: product.gstNo,
                  rate: product.rate,
                  supplier: product.supplier,
                ))
            .then((_) => Provider.of<CartProvider>(context, listen: false)
                .removeItem(productId));
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      child: Card(
        elevation: 8.0,
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(imageUrl!),
            ),
            title: Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
              ),
            ),
            subtitle:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Total: \u{20B9} ${(price * quantity)}'),
              SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width * 0.45,
                height: 6.h,
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: HexColor('#D2D0D3'),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Provider.of<ProductsProvider>(context, listen: false)
                            .updateProduct(
                                productId,
                                Product(
                                  id: productId,
                                  size: product.size,
                                  title: product.title,
                                  type: product.type,
                                  color: product.color,
                                  dateTime: product.dateTime,
                                  quantity: product.quantity! + 1,
                                  gstNo: product.gstNo,
                                  rate: product.rate,
                                  supplier: product.supplier,
                                ))
                            .then((_) => Provider.of<CartProvider>(context,
                                    listen: false)
                                .removeItem(productId));
                      },
                      child: Icon(
                        Icons.delete,
                        color: Colors.red[500],
                        size: 20,
                      ),
                    ),
                    Container(
                      width: 15.w,
                      margin: EdgeInsets.symmetric(horizontal: 3),
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.white,
                      ),
                      child: Text(
                        quantity.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Provider.of<ProductsProvider>(context, listen: false)
                            .updateProduct(
                                productId,
                                Product(
                                  id: productId,
                                  size: product.size,
                                  title: product.title,
                                  type: product.type,
                                  color: product.color,
                                  dateTime: product.dateTime,
                                  quantity: product.quantity! - 1,
                                  gstNo: product.gstNo,
                                  rate: product.rate,
                                  supplier: product.supplier,
                                ))
                            .then(
                              (_) => cart.increaseItemQuantity(
                                  productId, price, title, imageUrl),
                            );
                      },
                      child: Icon(
                        Icons.add,
                        color: Colors.black,
                        size: 20,
                      ),
                    )
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
