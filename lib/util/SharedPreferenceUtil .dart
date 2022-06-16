import 'package:shared_preferences/shared_preferences.dart';

/// 缓存
class SharedPreferenceUtil {
  static const String ACCOUNT_NUMBER = "account_number";
  static const String USERNAME = "username";
  static const String PASSWORD = "password";

  ///保存账号
  static void saveUser(
    String formUsername,
    String formPassword,
  ) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("formUsername", formUsername);
    sp.setString("formPassword", formPassword);
  }

  /// 获取表单用户名
  static Future<String> getFormUsername() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
      return sp.get("formUsername") != null ? sp.get("formUsername").toString() : "";
  }

  /// 获取表单密码
  static Future<String> getFormPassword() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
      return sp.get("formPassword") != null ?  sp.get("formPassword").toString() : "";
  }
}
