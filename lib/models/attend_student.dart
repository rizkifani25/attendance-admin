import 'package:attendance_admin/models/position.dart';

class AttendStudent {
  final String image;
  final String time;
  final PositionStudent positionStudent;
  final double distance;

  AttendStudent({this.image, this.time, this.positionStudent, this.distance});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['image'] = this.image;
    data['time'] = this.time;
    data['position'] = this.positionStudent;
    data['distance'] = this.distance;
    return data;
  }

  factory AttendStudent.fromJson(Map<String, dynamic> json) {
    return AttendStudent(
      image: json['image'] ?? '-',
      time: json['time'] ?? '-',
      positionStudent: PositionStudent.fromJson(json['position']),
      distance: json['distance'] ?? 0.0,
    );
  }
}
