import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManagerService {
  final String credentialKey = 'admin_email';

  Future<void> setAdmin(User user) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(credentialKey, user.email);
  }

  Future<String> getAdmin() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String adminEmail = sharedPreferences.getString(credentialKey) ?? '';
    return adminEmail;
  }
}
