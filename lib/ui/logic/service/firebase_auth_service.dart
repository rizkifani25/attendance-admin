import 'package:attendance_admin/models/models.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireBaseAuthService {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<SignInResponse> signInWithEmail({Admin admin}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: admin.email,
        password: admin.password,
      );
      return SignInResponse(user: userCredential.user);
    } catch (e) {
      return SignInResponse(message: e.toString());
    }
  }
}
