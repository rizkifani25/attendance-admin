import 'dart:convert';

import 'package:attendance_admin/constant/Constant.dart';
import 'package:attendance_admin/models/models.dart';
import 'package:attendance_admin/ui/logic/service/services.dart';
import 'package:http/http.dart' as http;

class AttendanceApi {
  AttendanceApi();

  Future<List<Room>> getRoomList() async {
    return Room.getRoom();
  }

  Future<List<String>> getTimeList() async {
    return Time.getRoomTime();
  }

  Future<List<Major>> getMajorList() async {
    return Major.getMajor();
  }

  Future<SignInResponse> signInAdmin(Admin admin) async {
    try {
      SignInResponse signInResponse = await FireBaseAuthService.signInWithEmail(admin: admin);

      if (signInResponse.user != null) {
        SessionManagerService().setAdmin(signInResponse.user);
        return SignInResponse(message: 'Login Success');
      } else {
        return SignInResponse(message: signInResponse.message);
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Failure');
    }
  }

  Future<RoomDetailResponse> getRoomDetail(String roomName, String date) async {
    try {
      final String listRoomDetailUrl =
          apiURL + 'room/detail?room_name=' + roomName + '&date=' + date;
      final http.Response response = await http.post(listRoomDetailUrl);

      if (response.statusCode != 200) {
        throw Exception('Failure');
      }

      var responseBody = jsonDecode(response.body);
      return RoomDetailResponse.fromJson(responseBody['data']);
    } catch (e) {
      print(e.toString());
      throw Exception('Failure');
    }
  }

  Future<BasicResponse> deleteStudent({String studentId}) async {
    try {
      final String deleteStudentUrl = apiURL + 'student/delete?student_id=' + studentId;
      var response = await http.post(deleteStudentUrl);

      if (response.statusCode != 200) {
        throw Exception('Failure');
      }

      var responseBody = jsonDecode(response.body);
      if (responseBody['data'] != null) {
        BasicResponse basicResponse = BasicResponse.fromJson(responseBody['data']);
        return basicResponse;
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Failure');
    }
  }

  Future<List<Student>> getListStudent({String studentId}) async {
    try {
      String param = studentId != null ? 'student/list?student_id=' + studentId : 'student/list';
      final String listStudentUrl = apiURL + param;
      var response = await http.post(listStudentUrl);

      if (response.statusCode != 200) {
        throw Exception('Failure');
      }

      var responseBody = jsonDecode(response.body);
      if (responseBody['data'] != null) {
        var tagObjsJson = responseBody['data'] as List;
        List<Student> listStudent = tagObjsJson.map((e) => Student.fromJson(e)).toList();
        return listStudent;
      } else {
        return null;
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
      var response = await http.post(registerStudentUrl);

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

  Future<BasicResponse> updateRoomDetail(
    String time,
    String roomName,
    String date,
    Time updatedTime,
  ) async {
    try {
      RegisterRoomRequest registerRoomRequest = new RegisterRoomRequest();

      registerRoomRequest.roomName = roomName;
      registerRoomRequest.updatedTime = updatedTime;
      registerRoomRequest.date = date;
      registerRoomRequest.time = time;

      print(jsonEncode(registerRoomRequest.toJson()));

      Map<String, String> requestHeaders = {'Content-type': 'application/json'};

      var response = await http.post(
        apiURL + 'room/register',
        body: jsonEncode(registerRoomRequest.toJson()),
        headers: requestHeaders,
      );

      print(response);

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
      print(e);
      throw Exception('Failure');
    }
  }
}
