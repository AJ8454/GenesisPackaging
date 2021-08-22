import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import '../providers/ordersProvider.dart';
import '../widgets/appbar_design.dart';
import '../widgets/order_item.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isLoading = false;
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      try {
        setState(() {
          _isLoading = true;
        });
        await Provider.of<OrdersProvider>(context, listen: false)
            .fetchAndSetOrders();
        setState(() {
          _isLoading = false;
        });
      } catch (error) {
        Fluttertoast.showToast(
          msg: 'Your Order Basket is empty',
          fontSize: 15.sp,
          backgroundColor: HexColor('#E2E0DF'),
          textColor: Theme.of(context).errorColor,
        );
        setState(() {
          _isLoading = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<OrdersProvider>(context);
    return Scaffold(
      backgroundColor: HexColor('#F3F4F7'),
      appBar: PreferredSize(
        child: AppBarDesign(
          icon: Icons.arrow_back,
          text: 'Your Orders',
        ),
        preferredSize: Size.fromHeight(100),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: orderData.orders.length,
              itemBuilder: (context, i) => OrderItem(
                orderData.orders[i],
              ),
            ),
    );
  }
}
