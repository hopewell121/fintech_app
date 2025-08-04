import 'package:flutter/material.dart';
import 'package:online_shop_app/provider/product_provider.dart';
import 'package:online_shop_app/screens/bottom_container.dart';


import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductProvider(),
      child: MaterialApp(
        home:BottomContainer()
      ),
    );
  }
}

