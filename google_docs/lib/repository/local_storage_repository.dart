import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageRepositor{
  void setToken (String token )async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('x-auth-token', token);
  }

   Future<String?>  getToken (String token  )async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('x-auth-token');
  return token;
  }

}