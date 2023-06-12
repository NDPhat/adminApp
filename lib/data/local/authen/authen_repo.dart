import 'package:shared_preferences/shared_preferences.dart';

class AuthenRepository {
  Future<bool> loadHandleAutoLoginApp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("flagAutoLogin") ?? false;
  }

  Future<String> getMailHandleAutoLoginApp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("mail") ?? "";
  }

  void handleAutoLoginApp(bool value) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool("flagAutoLogin", value);
    });
  }

  void handleMailLoginApp(String value) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("mail", value);
    });
  }
}
