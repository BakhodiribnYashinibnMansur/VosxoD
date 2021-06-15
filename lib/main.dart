import 'package:VosxoD/provider/cart_provider.dart';
import 'package:VosxoD/provider/home_data_provider.dart';

import 'package:VosxoD/screen/register_screen.dart';
import 'package:VosxoD/screen/splash_screen.dart';
import 'package:VosxoD/utils/my_prefs.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import 'package:sizer/sizer.dart';

import 'provider/payment_provider.dart';
import 'service/get_home_api.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GetHomeData getHomeData = GetHomeData();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider.value(
        //   value: HomeDataProvider(),
        // ),
        // ChangeNotifierProvider.value(
        //   value: CartProviderData(),
        // ),
        // ChangeNotifierProvider.value(
        //   value: PaymentProvider(),
        // ),
        ChangeNotifierProvider<HomeDataProvider>(
          create: (_) {
            return HomeDataProvider();
          },
        ),
        ChangeNotifierProvider<CartProviderData>(
          create: (_) {
            return CartProviderData();
          },
        ),
        ChangeNotifierProvider<PaymentProvider>(
          create: (_) {
            return PaymentProvider();
          },
        ),
        // ChangeNotifierProvider<Store>(
        //   create: (_) {
        //     return Store();
        //   },
        // ),
      ],
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'VosxoD',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: MyHomePage(),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var token = MyPref.token ?? null;
    return token != null ? SplashScreen() : RegisterScreen();
  }
}
