import 'package:flutter/material.dart';
import '../../widgets/product_item.dart';
import '../providers/productsProvider.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
  Future<void> fetchAllProducts(context) async {
    try {
      await Provider.of<ProductsProvider>(context).fetchAndSetProducts();
    } catch (error) {}
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final productData = Provider.of<ProductsProvider>(context);
    return RefreshIndicator(
      onRefresh: () => fetchAllProducts(context),
      child: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: productData.items.length,
        itemBuilder: (context, i) => ChangeNotifierProvider.value(
          value: productData.items[i],
          child: ProductItem(),
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: (width) / (height / 1.7),
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
      ),
    );
  }
}
