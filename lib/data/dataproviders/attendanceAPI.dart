import 'dart:convert';

import 'package:attendance_admin/constant/Constant.dart';
import 'package:attendance_admin/models/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AttendanceApi {
  final http.Client httpClient;

  AttendanceApi({@required this.httpClient});

  Future<List<Room>> getRoomList() async {
    return Room.getRoom();
  }

  Future<List<String>> getTimeList() async {
    return Time.getRoomTime();
  }

  Future<List<Major>> getMajorList() async {
    return Major.getMajor();
  }

  Future<Admin> loginAdmin(String username, String password) async {
    try {
      final String loginAdminUrl =
          apiURL + 'admin/login?username=' + username + '&password=' + password;
      final http.Response response = await httpClient.post(loginAdminUrl);

      if (response.statusCode != 200) {
        throw Exception('Failure');
      }

      var responseBody = jsonDecode(response.body);
      var finalResponse = Admin(
        username: responseBody['data'][0]['username'],
        password: responseBody['data'][0]['password'],
      );
      return finalResponse;
    } catch (e) {
      print(e.toString());
      throw Exception('Failure');
    }
  }

  Future<List<Time>> getRoomDetail(String roomName, String date) async {
    try {
      final String listRoomDetailUrl = apiURL + 'room/list?room_name=' + roomName + '&date=' + date;
      final http.Response response = await httpClient.post(listRoomDetailUrl);

      if (response.statusCode != 200) {
        throw Exception('Failure');
      }

      var responseBody = jsonDecode(response.body);
      if (responseBody['data'].toString() == '[]') {
        return [];
      } else {
        List<Time> listTemp = [
          Time.fromJson(responseBody['data'][0]['time1']),
          Time.fromJson(responseBody['data'][0]['time2']),
          Time.fromJson(responseBody['data'][0]['time3']),
          Time.fromJson(responseBody['data'][0]['time4']),
        ];
        return listTemp;
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Failure');
    }
  }

  Future<BasicResponse> addNewStudent(
    String studentId,
    String studentName,
    String password,
    String batch,
    String major,
  ) async {
    try {
      final String registerStudentUrl = apiURL +
          'student/register?student_id=' +
          studentId +
          '&student_name=' +
          studentName +
          '&password=' +
          password +
          '&batch=' +
          batch +
          '&major=' +
          major;
      final http.Response response = await httpClient.post(registerStudentUrl);

      if (response.statusCode != 200) {
        throw Exception('Failure');
      }

      var responseBody = jsonDecode(response.body);
      if (responseBody['responseCode'] != 200) {
        BasicResponse basicResponse = new BasicResponse(
          responseCode: 400,
          responseMessage: responseBody['responseMessage'],
        );
        return basicResponse;
      } else {
        var responseBody = jsonDecode(response.body);
        BasicResponse basicResponse = BasicResponse.fromJson(responseBody);
        return basicResponse;
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Failure');
    }
  }
}
