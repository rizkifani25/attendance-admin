import 'package:attendance_admin/models/models.dart';

class RegisterRoomRequest {
  String roomName;
  Time updatedTime;
  String date;
  String time;

  RegisterRoomRequest({this.roomName, this.updatedTime, this.date, this.time});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['room_name'] = this.roomName;
    data['updated_time'] = this.updatedTime;
    data['date'] = this.date;
    data['time'] = this.time;
    return data;
  }

  factory RegisterRoomRequest.fromJson(Map<String, dynamic> json) {
    return RegisterRoomRequest(
      roomName: json['room_name'],
      updatedTime: json['updated_time'],
      date: json['date'],
      time: json['time'],
    );
  }
}
