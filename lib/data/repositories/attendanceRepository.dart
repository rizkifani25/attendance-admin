import 'package:attendance_admin/data/dataproviders/dataproviders.dart';
import 'package:attendance_admin/models/models.dart';
import 'package:flutter/cupertino.dart';

class AttendanceRepository {
  final AttendanceApi attendanceApi;
  AttendanceRepository({@required this.attendanceApi});

  Future<List<Room>> getListOfRoom() {
    return attendanceApi.getRoomList();
  }

  Future<List<String>> getListOfTime() {
    return attendanceApi.getTimeList();
  }

  Future<List<Major>> getListOfMajor() {
    return attendanceApi.getMajorList();
  }

  Future<BasicResponse> getRoomDetail(String roomName, String date) async {
    BasicResponse basicResponse = await attendanceApi.getRoomDetail(roomName, date);
    return basicResponse;
  }

  // Admin
  Future<BasicResponse> updateRoomData(String time, String roomName, String date, Time updatedTime) async {
    BasicResponse basicResponse = await attendanceApi.updateRoomDetail(time, roomName, date, updatedTime);
    return basicResponse;
  }
}
