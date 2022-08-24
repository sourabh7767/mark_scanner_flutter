import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage{
  LocalStorage._();
 static String auth="Auth";
 static String email="email";
 static String name="Name";

   static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();


 static Future<void> SetString(String key,String value) async{
     _prefs.then((value1) => {
       value1.setString(key, value)
     });


  }
  static Future<String?> getString(String key) async{
  SharedPreferences sharedPreferences= await _prefs;
return sharedPreferences.getString(key);

  }
  static Future<bool> delectAllData() async{
   SharedPreferences sharedPreferences=await _prefs;
   return sharedPreferences.clear();
  }



}