// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:online_shop_app/screens/bottom_container.dart';
import 'package:online_shop_app/services/api_services.dart';
import 'package:online_shop_app/shared_preference/shared_preferences.dart';

class LoginProvider extends ChangeNotifier{

Future<void>login(context, String email, String password) async{

final url = ApiServices.loginUrl;

var response = await http.post(Uri.parse(url),
  headers: {'Content-Type': 'application/json'},
  body: jsonEncode({
    'email': email,
    'password': password,
   
  })
  );



  // print(response.body);
  //   print(response.statusCode);

  if(response.statusCode == 201){
  var data = jsonDecode(response.body);
  
  await Prefs.saveAccessToken(data['access_token']);
    print(data['access_token']);


    // print('success');
  }else {
    print(' something went wrong');
  }
Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomContainer()));
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Processing registration')));

  notifyListeners();

}
}