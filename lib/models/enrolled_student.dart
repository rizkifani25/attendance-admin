import 'package:attendance_admin/models/attend_student.dart';
import 'package:attendance_admin/models/out_student.dart';
import 'package:attendance_admin/models/status_attendance.dart';

class Enrolled {
  final String studentId;
  final StatusAttendance statusAttendance;
  final AttendStudent attendStudent;
  final OutStudent outStudent;

  Enrolled({this.studentId, this.statusAttendance, this.attendStudent, this.outStudent});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['student_id'] = this.studentId;
    data['status'] = this.statusAttendance;
    data['attend_time'] = this.attendStudent;
    data['out_time'] = this.outStudent;
    return data;
  }

  factory Enrolled.fromJson(Map<String, dynamic> json) {
    return Enrolled(
      studentId: json['student_id'] ?? '-',
      statusAttendance: StatusAttendance.fromJson(json['status']),
      attendStudent: AttendStudent.fromJson(json['attend_time']),
      outStudent: OutStudent.fromJson(json['out_time']),
    );
  }
}
