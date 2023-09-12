abstract class AuthenRepository {
  Future<bool> loadHandleAutoLoginApp();

  Future<bool> loadHandleFirstTimeUsingApp();
  Future<String> getMailHandleAutoLoginApp();

  void handleAutoLoginApp(bool value);

  void handleFirstTimeUsingApp(bool value);

  void handleMailLoginApp(String value);
}
