import 'package:attendance_admin/data/dataproviders/attendanceAPI.dart';
import 'package:attendance_admin/models/models.dart';
import 'package:attendance_admin/models/room_detail_response.dart';
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

  Future<List<Major>> getListOfMajor() {
    return attendanceApi.getMajorList();
  }

  Future<RoomDetailResponse> getRoomDetail(String roomName, String date) async {
    RoomDetailResponse roomDetailResponse = await attendanceApi.getRoomDetail(roomName, date);
    return roomDetailResponse;
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

  Future<BasicResponse> registerNewStudent(
    String studentId,
    String studentName,
    String password,
    String batch,
    String major,
  ) async {
    BasicResponse basicResponse = await attendanceApi.addNewStudent(
      studentId,
      studentName,
      password,
      batch,
      major,
    );
    return basicResponse;
  }
  // Admin

  Future<BasicResponse> updateRoomData(
    String time,
    String roomName,
    String date,
    Time updatedTime,
  ) async {
    BasicResponse basicResponse = await attendanceApi.updateRoomDetail(
      time,
      roomName,
      date,
      updatedTime,
    );
    return basicResponse;
  }
}
