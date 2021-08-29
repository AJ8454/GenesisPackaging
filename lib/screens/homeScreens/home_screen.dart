import 'package:flutter/material.dart';
import 'package:genesis_packaging/widgets/error_controller.dart';
import 'package:genesis_packaging/providers/productsProvider.dart';
import 'package:provider/provider.dart';
import '../../widgets/home_widgets/product_grid.dart';
import '../../utils/UserSimplePreferences.dart';
import '../../providers/email_sign_in_provider.dart';
import '../../providers/google_sign_in_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isLoading = false;
  var _isInit = true;

  @override
  void didChangeDependencies() {
    fetchAllProducts();
    super.didChangeDependencies();
  }

  Future<void> fetchAllProducts() async {
    try {
      if (_isInit) {
        setState(() {
          _isLoading = true;
        });
        await Provider.of<ProductsProvider>(context)
            .fetchAndSetProducts()
            .then((_) {
          setState(() {
            _isLoading = false;
          });
        }); // It work
      }
      _isInit = false;
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final String? eUserId, gUserId;
    final gProvider = Provider.of<GoogleSignInProvider>(context);
    final eProvider = Provider.of<EmailSignInProvider>(context);
    gUserId = gProvider.guserId;
    eUserId = eProvider.userId;
    if (gUserId != null) {
      UserSimplePreferences.setUserId(gUserId);
    }
    if (eUserId != null) {
      UserSimplePreferences.setEuserId(eUserId);
    }

    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : !_isInit
            ? ProductGrid()
            : ErrorController(
                errorTitle: 'No Products Added Yet.',
                errorDesc: 'Please add the Products.',
              );
  }
}
