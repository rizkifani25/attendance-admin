import 'package:attendance_admin/models/attend_student.dart';
import 'package:attendance_admin/models/out_student.dart';

class Enrolled {
  final String studentId;
  final int status;
  final AttendStudent attendStudent;
  final OutStudent outStudent;

  Enrolled({this.studentId, this.status, this.attendStudent, this.outStudent});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['student_id'] = this.studentId;
    data['status'] = this.status;
    data['attend_time'] = this.attendStudent;
    data['out_time'] = this.outStudent;
    return data;
  }

  factory Enrolled.fromJson(Map<String, dynamic> json) {
    return Enrolled(
      studentId: json['student_id'],
      status: json['status'],
      attendStudent: json['attend_time'],
      outStudent: json['out_time'],
    );
  }
}
