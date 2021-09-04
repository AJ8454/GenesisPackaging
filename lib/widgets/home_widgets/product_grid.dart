import 'package:flutter/material.dart';
import 'product_item.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../providers/productsProvider.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
  Future<void> fetchAllProducts(context) async {
    try {
      await Provider.of<ProductsProvider>(context).fetchAndSetProducts();
    } catch (error) {}
  }

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height / 3.6;
    // final width = MediaQuery.of(context).size.width / 1.3;
    final productData = Provider.of<ProductsProvider>(context);
    return RefreshIndicator(
      onRefresh: () => fetchAllProducts(context),
      child: StaggeredGridView.countBuilder(
        padding: const EdgeInsets.all(8),
        staggeredTileBuilder: (index) => StaggeredTile.count(2, 2.5),
        crossAxisCount: 4,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        itemCount: productData.items.length,
        itemBuilder: (context, i) => ChangeNotifierProvider.value(
          value: productData.items[i],
          child: ProductItem(),
        ),
      ),
    );
  }
}
