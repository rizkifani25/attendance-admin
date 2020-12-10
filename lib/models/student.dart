import 'package:flutter/foundation.dart';

class Student {
  String studentId;
  String studentName;
  String password;
  String batch;
  String major;
  List historyRoom;

  Student({this.studentId, this.studentName, this.password, this.batch, this.major, this.historyRoom});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["student_id"] = this.studentId ?? '-';
    data["student_name"] = this.studentName ?? '-';
    data["password"] = this.password ?? '-';
    data["batch"] = this.batch ?? '-';
    data["major"] = this.major ?? '-';
    data["history_room"] = this.historyRoom;
    return data;
  }

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      studentId: json['student_id'] ?? '-',
      studentName: json['student_name'] ?? '-',
      password: json['password'] ?? '-',
      batch: json['batch'] ?? '-',
      major: json['major'] ?? '-',
      historyRoom: json['history_room'],
    );
  }

  @override
  String toString() {
    return 'Student(studentId: $studentId, studentName: $studentName, password: $password, batch: $batch, major: $major, historyRoom: $historyRoom)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Student && o.studentId == studentId && o.studentName == studentName && o.password == password && o.batch == batch && o.major == major && listEquals(o.historyRoom, historyRoom);
  }

  @override
  int get hashCode {
    return studentId.hashCode ^ studentName.hashCode ^ password.hashCode ^ batch.hashCode ^ major.hashCode ^ historyRoom.hashCode;
  }
}
