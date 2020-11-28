import 'package:attendance_admin/data/dataproviders/dataproviders.dart';
import 'package:attendance_admin/models/lecturer.dart';
import 'package:attendance_admin/models/models.dart';

class LecturerRepository {
  final AttendanceApi attendanceApi;
  LecturerRepository({this.attendanceApi});

  Future<BasicResponse> registerNewLecturer(
    String lecturerEmail,
    String lecturerName,
    String password,
  ) async {
    BasicResponse basicResponse = await attendanceApi.addNewLecturer(
      lecturerEmail: lecturerEmail,
      lecturerName: lecturerName,
      password: password,
    );
    return basicResponse;
  }

  Future<BasicResponse> deleteLecturer({String lecturerEmail}) async {
    BasicResponse basicResponse = await attendanceApi.deleteLecturer(lecturerEmail: lecturerEmail);
    return basicResponse;
  }

  Future<List<Lecturer>> getListLecturer({String lecturerName}) async {
    List<Lecturer> listLecturer = await attendanceApi.getListLecturer(lecturerName: lecturerName);
    return listLecturer;
  }
}
