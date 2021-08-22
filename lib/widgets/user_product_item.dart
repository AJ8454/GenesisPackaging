import 'package:flutter/material.dart';
import '../../providers/productsProvider.dart';
import 'package:provider/provider.dart';

class UserProductItem extends StatelessWidget {
  final String? id;
  final String title;
  final String imageUrl;

  const UserProductItem({
    Key? key,
    required this.id,
    required this.title,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final snackbar = ScaffoldMessenger.of(context);
    return Container(
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade600,
            blurRadius: 2,
            spreadRadius: 1,
          ),
        ],
      ),
      child: ListTile(
        title: Text(title),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(
            imageUrl,
          ),
        ),
        trailing: Container(
          width: 100,
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed('/EditProductScreen', arguments: id);
                },
                color: Colors.brown,
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () async {
                  try {
                    await Provider.of<ProductsProvider>(context, listen: false)
                        .deleteProduct(id!)
                        .then(
                          (_) => snackbar.showSnackBar(
                            SnackBar(
                              content: Text('Product Deleted',
                                  textAlign: TextAlign.center),
                              backgroundColor: Colors.red[400],
                            ),
                          ),
                        );
                  } catch (error) {
                    snackbar.showSnackBar(
                      SnackBar(
                        content: Text('Deleting Failed',
                            textAlign: TextAlign.center),
                      ),
                    );
                  }
                },
                color: Theme.of(context).errorColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
