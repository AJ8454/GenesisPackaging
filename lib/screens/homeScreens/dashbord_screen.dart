import 'package:flutter/material.dart';
import '../../widgets/home_widgets/dashboard_item.dart';
import 'package:provider/provider.dart';
import '../../providers/productsProvider.dart';

class DashBord extends StatelessWidget {
  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<ProductsProvider>(context, listen: false)
        .fetchAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final productData = Provider.of<ProductsProvider>(context);
    return RefreshIndicator(
      onRefresh: () => _refreshProducts(context),
      child: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: productData.items.length,
        itemBuilder: (context, i) => ChangeNotifierProvider.value(
          value: productData.items[i],
          child: DashboardItem(),
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: (width / 4.5) / (height / 10),
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
      ),
    );
  }
}
