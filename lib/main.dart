import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/advance_payment_provider.dart';
import '../providers/auth.dart';
import '../providers/customer_provider.dart';
import '../providers/fertilizer_provider.dart';
import '../providers/purches_fertilizer_cost_provider.dart';
import '../providers/selected_customer_provider.dart';
import '../providers/supply_killo_provider.dart';
import '../providers/tea_buyer.dart';
import '../ui/add_advance_payment.dart';
import '../ui/add_customer.dart';
import '../ui/add_fertilizer.dart';
import '../ui/fertilizer_over_view.dart';
import '../ui/dashboard/home_screen.dart';
import '../ui/onboarding/login.dart';
import '../ui/summery/summery_home_screen.dart';
import '../ui/supplied_killo.dart';
import './ui/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProvider(create: (ctx) => TeaBuyer()),
        ChangeNotifierProvider(create: (ctx) => CustomerProvider()),
        ChangeNotifierProvider(create: (ctx) => FertilizerProvider()),
        ChangeNotifierProvider(create: (ctx) => SuppliKilloProvider()),
        ChangeNotifierProvider(create: (ctx) => AdvancePaymentProvider()),
        ChangeNotifierProvider(create: (ctx) => PurchesFertilzerCostProvider()),
        ChangeNotifierProvider(
          create: (ctx) => SelectedCustomerProvider(),
        )
      ],
      child: Consumer<Auth>(builder: (context, auth, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Tea Buyer',
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          home: auth.isAuth == true
              ? const HomeScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? const SplashScreen()
                          : const Login()),
          routes: {
            HomeScreen.routName: (ctx) => const HomeScreen(),
            AddCustomers.routName: (ctx) => const AddCustomers(),
            FertilizerOverView.routName: (ctx) => const FertilizerOverView(),
            AddFertilizer.routName: (ctx) => const AddFertilizer(),
            SuppliedKillos.routName: (ctx) => SuppliedKillos(),
            AddAdvancePayments.routName: (ctx) => AddAdvancePayments(),
            SummeryHomeScreen.routeName: (ctx) => const SummeryHomeScreen(),
          },
        );
      }),
    );
  }
}
