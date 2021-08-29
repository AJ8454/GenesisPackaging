import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'providers/cartProvider.dart';
import 'providers/email_sign_in_provider.dart';
import 'providers/employeeAttendance_Provider.dart';
import 'providers/employeeProvider.dart';
import 'providers/google_sign_in_provider.dart';
import 'providers/ordersProvider.dart';
import 'providers/productsProvider.dart';
import 'providers/salaryReport_sheets_api.dart';
import 'screens/cart_screen.dart';
import 'screens/employeeScreen/attendanceScreen.dart';
import 'screens/employeeScreen/attendance_list_screen.dart';
import 'screens/employeeScreen/editEmployee_Screen.dart';
import 'screens/employeeScreen/employeeProfileScreen.dart';
import 'screens/employeeScreen/employee_screen.dart';
import 'screens/employeeScreen/employee_users_Screen.dart';
import 'screens/employeeScreen/salaryReportScreen.dart';
import 'screens/initial_page.dart';
import 'screens/orders_screen.dart';
import 'screens/productScreen/edit_product_screen.dart';
import 'screens/productScreen/produt_detail_screen.dart';
import 'screens/productScreen/user_product_screen.dart';
import 'utils/UserSimplePreferences.dart';
import 'widgets/header_widgets/app_drawer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EmployeeSalaryReportApi.init();
  await UserSimplePreferences.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => GoogleSignInProvider()),
        ChangeNotifierProvider(create: (ctx) => EmailSignInProvider()),
        ChangeNotifierProvider(create: (ctx) => ProductsProvider()),
        ChangeNotifierProvider(create: (ctx) => CartProvider()),
        ChangeNotifierProvider(create: (ctx) => EmployeeProvider()),
        ChangeNotifierProvider(create: (ctx) => EmployeeAttendanceProvider()),
        ChangeNotifierProxyProvider<GoogleSignInProvider, OrdersProvider>(
          update: (ctx, auth, previousProducts) => OrdersProvider(
            auth.guserId,
            previousProducts == null ? [] : previousProducts.orders,
          ),
          create: (ctx) => OrdersProvider('', []),
        ),
      ],  
      child: Sizer(builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Genesis Packaging',
          theme: ThemeData(
            primarySwatch: Colors.deepOrange,
            fontFamily: GoogleFonts.robotoSlab().fontFamily,
          ),
          initialRoute: '/',
          routes: {
            '/': (ctx) => InitialPage(),
            '/userProductScreen': (ctx) => UserProductsScreen(),
            '/EditProductScreen': (ctx) => EditProductScreen(),
            '/EmployeeScreen': (ctx) => EmployeeScreen(),
            '/EmployeeUserScreen': (ctx) => EmployeeUserScreen(),
            '/EditEmployeeScreen': (ctx) => EditEmployeeScreen(),
            '/EmployeeAttendance': (ctx) => EmployeeAttendance(),
            '/SalaryReprotScreen': (ctx) => SalaryReprotScreen(),
            '/ProductDetailScreen': (ctx) => ProductDetailScreen(),
            '/EmployeeProfileScreen': (ctx) => EmployeeProfileScreen(),
            '/OrdersScreen': (ctx) => OrdersScreen(),
            '/cart': (ctx) => CartScreen(),
            '/AppDrawer': (ctx) => AppDrawer(),
            '/AttendanceListScreen': (ctx) => AttendanceListScreen(),
          },
        );
      }),
    );
  }
}
