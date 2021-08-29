import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import '../widgets/header_widgets/appbar_design.dart';
import '../providers/ordersProvider.dart';
import '../widgets/cart_item.dart';
import '../providers/cartProvider.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: PreferredSize(
        child: AppBarDesign(
          icon: Icons.arrow_back,
          text: 'Your Cart',
        ),
        preferredSize: Size.fromHeight(100),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Chip(
              label: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Total : ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                    ),
                  ),
                  Text(
                    '\u{20B9} ${cart.totalAmount.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              backgroundColor: HexColor('#374A5A'),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: cart.itemCount,
              itemBuilder: (context, i) => CartItemView(
                id: cart.items.values.toList()[i].id!,
                title: cart.items.values.toList()[i].title,
                price: cart.items.values.toList()[i].price,
                quantity: cart.items.values.toList()[i].quantity,
                imageUrl: cart.items.values.toList()[i].imageUrl,
                productId: cart.items.keys.toList()[i],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: cart.totalAmount == 0.0
          ? null
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: OrderButton(cart: cart),
            ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final CartProvider cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: HexColor('#500B28'),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(
              color: HexColor('#374A5A'),
            )),
        elevation: 8,
        padding: EdgeInsets.symmetric(horizontal: 50),
      ),
      onPressed: () async {
        await Provider.of<OrdersProvider>(context, listen: false)
            .addOrder(
          widget.cart.items.values.toList(),
          widget.cart.totalAmount,
        )
            .then((_) {
          widget.cart.clear();
          Navigator.of(context).pop();
        });
      },
      child: Text(
        'SUPPLY ORDER',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
