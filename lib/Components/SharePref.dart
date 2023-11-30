import 'package:shared_preferences/shared_preferences.dart';

class SharePref{
  Future<void> SaveToken(data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", data);
  }
  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
     var token = prefs.get("token");
    return token.toString();
  }

}