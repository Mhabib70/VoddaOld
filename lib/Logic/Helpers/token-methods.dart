
import 'package:shared_preferences/shared_preferences.dart';

class Token{
  static Future<String?> getToken() async{
    final prefs = await SharedPreferences.getInstance();
    String token=prefs.getString('full-token')??'';
    if(!token.isEmpty){
      return "Bearer " + token;
    }else{
      return null;
    }
  }

  static setToken(String token) async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('full-token', token);
  }


  static Future<bool> removeToken() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove('full-token');
  }


  static Future<String?> getNotifToken() async{
    final prefs = await SharedPreferences.getInstance();
    String notifToken=prefs.getString('notif-token')??'';
    if(!notifToken.isEmpty){
      return notifToken;
    }else{
      return null;
    }
  }

  static setNotifToken(String notifToken) async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('notif-token', notifToken);
  }

}