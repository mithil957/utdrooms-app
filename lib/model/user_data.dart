import 'package:shared_preferences/shared_preferences.dart';

class UserData {

  static late SharedPreferences _preferences;

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setMarkedRoom(String room) async =>
      await _preferences.setString("lastMarkedRoom", room);

  static String? getMarkedRoom() => _preferences.getString("lastMarkedRoom");
}