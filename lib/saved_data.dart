import 'package:shared_preferences/shared_preferences.dart';

class saved_Data{

  static Future<bool> get_status()
  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool status=prefs.getBool("status");
    return status;
  }
}