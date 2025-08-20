import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:online_shop_app/screens/profile/model.dart';
import 'package:online_shop_app/services/api_services.dart';
import 'package:online_shop_app/shared_preference/shared_preferences.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileModel? _profileModel;
  ProfileModel? get profileModel => _profileModel;

  Future<void> getProfile() async {
    // Simulate a network call to fetch profile data
    final url = ApiServices.profileUrl;

    //getting the token
    final token = await Prefs.displayAccessToken();
    var response = await http.get(
      Uri.parse(url),

      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      final data = ProfileModel.fromJson(body);

      _profileModel = data;
      notifyListeners();
    } else {
      print('Something went wrong: ${response.statusCode}');
      throw Exception(' Failed to load data');
    }
  }
}
