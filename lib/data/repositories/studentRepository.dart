import 'package:attendance_admin/data/dataproviders/dataproviders.dart';
import 'package:attendance_admin/models/models.dart';

class StudentRepository {
  final AttendanceApi attendanceApi;
  StudentRepository({this.attendanceApi});

  Future<BasicResponse> registerNewStudent(String studentId, String studentName, String password, String batch, String major) async {
    BasicResponse basicResponse = await attendanceApi.addNewStudent(studentId: studentId, studentName: studentName, password: password, batch: batch, major: major);
    return basicResponse;
  }

  Future<BasicResponse> deleteStudent({String studentId}) async {
    BasicResponse basicResponse = await attendanceApi.deleteStudent(studentId: studentId);
    return basicResponse;
  }

  Future<BasicResponse> getListStudent({String studentId}) async {
    BasicResponse basicResponse = await attendanceApi.getListStudent(studentId: studentId);
    return basicResponse;
  }
}
