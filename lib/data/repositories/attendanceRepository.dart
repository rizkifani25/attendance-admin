import 'package:attendance_admin/data/dataproviders/attendanceAPI.dart';
import 'package:attendance_admin/models/models.dart';
import 'package:flutter/cupertino.dart';

class AttendanceRepository {
  final AttendanceApi attendanceApi;
  AttendanceRepository({@required this.attendanceApi});

  Admin admin;

  Future<List<Room>> getListOfRoom() {
    return attendanceApi.getRoomList();
  }

  Future<List<String>> getListOfTime() {
    return attendanceApi.getTimeList();
  }

  Future<List<Time>> getRoomDetail(String roomName, String date) async {
    List<Time> roomDetail = await attendanceApi.getRoomDetail(roomName, date);
    return roomDetail;
  }

  // Admin
  Future<Admin> getLoginInfo(String username, String password) async {
    Admin admin = await attendanceApi.loginAdmin(username, password);
    this.admin = admin;
    return admin;
  }

  Future<Admin> getCurrentLoginInfo() async {
    return this.admin;
  }

  Future<Admin> logOutAdmin() async {
    return null;
  }
  // Admin
}
