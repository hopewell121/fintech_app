import 'package:flutter/material.dart';
import 'package:online_shop_app/provider/product_provider.dart';

import 'package:online_shop_app/auth/register/createUser.dart';
import 'package:online_shop_app/shared_preference/shared_preferences.dart';


import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Prefs.init();
  await Prefs.initCheck();
  
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
        home:UserForm()
      ),
    );
  }
}

