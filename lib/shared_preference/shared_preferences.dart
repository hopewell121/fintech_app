// ignore_for_file: constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

class Prefs{
  static late SharedPreferences _preferences;
  static const  _emailController = 'email';
  static const  _passwordController = 'password';
  
  static const  _access_Token = 'access_token';
  static const  _refresh_Token = 'refresh_token';



//method to initialize shared preference

  static Future init()async{
    return _preferences = await SharedPreferences.getInstance();
  }

// method to check your shared prefrences from the debug sonsole

static initCheck(){
  print('shared preference inititialization');
}

// method to save or set the email and password in my shared prefrences

static Future<bool> saveEmail(String emailValue)async{
  return _preferences.setString(_emailController, emailValue);
}

static Future<bool> savePassword(String passwordValue)async{
  return _preferences.setString(_passwordController, passwordValue);
}

static Future<bool> saveAccessToken(String accessTokenValue)async{
  return _preferences.setString(_access_Token, accessTokenValue);
}

static Future<bool> saveRefreshToken(String refreshTokenValue)async{
  return _preferences.setString(_refresh_Token, refreshTokenValue);
}

// method to dispay, load or get the data we hare saved in our shared preferences

static String? displayEmail() => _preferences.getString(_emailController);

static String? displayPassword() => _preferences.getString(_passwordController);

static String? displayAccessToken() => _preferences.getString(_access_Token);

static String? displayRefreshToken() => _preferences.getString(_refresh_Token);

// method to clear or delete your data from the shared preferences

static Future clearData()async{
  return _preferences.clear();
}

}
