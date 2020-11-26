import 'package:attendance_admin/data/dataproviders/dataproviders.dart';
import 'package:attendance_admin/models/models.dart';
import 'package:attendance_admin/ui/logic/service/services.dart';

class AdminRepository {
  final AttendanceApi attendanceApi;
  AdminRepository({this.attendanceApi});

  // Admin Login
  Future<SignInResponse> signIn(Admin admin) async {
    SignInResponse signInResponse = await attendanceApi.signInAdmin(admin);
    return signInResponse;
  }

  // Current Admin Info
  Future<String> getCurrentSignInInfo() async {
    Future<String> adminEmail = SessionManagerService().getAdmin();
    return adminEmail;
  }

  // Logout Admin Info
  Future<String> logOutAdmin() async {
    return null;
  }
}
