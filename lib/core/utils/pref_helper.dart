import 'package:shared_preferences/shared_preferences.dart';

class PrefHelper{

static const String _tokenKey='auth_token';  // دا ال key الي هميز بيه المكان الموجود في ال sharedPref
                                             //static ->  بحطها علشان اقدر انادي علي المتغير في كلاسات تانيه

 static Future<void>saveToken(String token)async{
    final prefs=await SharedPreferences.getInstance();
   await prefs.setString(_tokenKey, token);
  }


  static Future<String?>getToken()async{
    final prefs=await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);

  }


  static Future<void>clearToken()async{
    final prefs=await SharedPreferences.getInstance();
    prefs.remove(_tokenKey);

  }



}