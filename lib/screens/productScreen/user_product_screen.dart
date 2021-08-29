import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../widgets/header_widgets/appbar_design.dart';
import '../../widgets/user_product_item.dart';
import 'package:provider/provider.dart';
import '../../providers/productsProvider.dart';

class UserProductsScreen extends StatelessWidget {
  Future<void> _refreshProducts(BuildContext context) async {
    try {
      await Provider.of<ProductsProvider>(context, listen: false)
          .fetchAndSetProducts(true);
    } catch (error) {
      Fluttertoast.showToast(
        msg: 'No Products Added Yet',
        fontSize: 12,
        backgroundColor: HexColor('#E2E0DF'),
        textColor: Theme.of(context).errorColor,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        child: AppBarDesign(
          icon: Icons.arrow_back,
          text: 'All Products',
        ),
        preferredSize: Size.fromHeight(100),
      ),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<ProductsProvider>(
                    builder: (ctx, productData, _) => Padding(
                      padding: EdgeInsets.all(8),
                      child: ListView.builder(
                        itemCount: productData.items.length,
                        itemBuilder: (_, i) => Column(
                          children: [
                            UserProductItem(
                              id: productData.items[i].id!,
                              title: productData.items[i].title!,
                              imageUrl: productData.items[i].imageUrl,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {
          Navigator.of(context).pushNamed('/EditProductScreen');
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
