import 'package:shared_preferences/shared_preferences.dart';

class Util {

  void setApiAddress(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("API_IP", value);
  }

  Future<String> getApiAddress() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("API_IP")??"";
  }

  void setIsApiMode(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isApiMode", value);
  }

  Future<bool> getIsApiMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isApiMode")??false;
  }

  void setIsActiveIndex(int index) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("isSelectedIndex", index);
  }

  Future<int> getIsActiveIndex() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt("isSelectedIndex")??0;
  }



}