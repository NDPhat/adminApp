import 'package:admin/data/remote/authen/authen_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenRepoImpl extends AuthenRepository {
  @override
  Future<String> getMailHandleAutoLoginApp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("mail") ?? "";
  }

  @override
  void handleAutoLoginApp(bool value) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool("flagAutoLogin", value);
    });
  }

  @override
  void handleFirstTimeUsingApp(bool value) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool("flagIntro", value);
    });
  }

  @override
  void handleMailLoginApp(String value) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("mail", value);
    });
  }

  @override
  Future<bool> loadHandleAutoLoginApp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("flagAutoLogin") ?? false;
  }

  @override
  Future<bool> loadHandleFirstTimeUsingApp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("flagIntro") ?? false;
  }
}
