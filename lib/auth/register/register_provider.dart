import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:online_shop_app/services/api_services.dart';


class RegisterProvider extends ChangeNotifier {

Future<void>register(context, String name, String email, String password, String avatar )async{
  //define the Url

  final url = ApiServices.registerUrl;

  var resonse = await http.post(Uri.parse(url),
  headers: {'Content-Type': 'application/json'},
  body: jsonEncode({
    'name': name,
    'email': email,
    'password': password,
    'avatar': avatar
  })
  );
    print(resonse.body);
    print(resonse.statusCode);

  if(resonse.statusCode == 201){
    // print('success');
    showDialog(context: context, builder: (context){
      return AlertDialog(
        content: Text('User Created Successfully'),
      );
    });


  }else {
    print(' something went wrong');
  }

  notifyListeners();
  

}

}