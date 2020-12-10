import 'dart:async';

import 'package:attendance_admin/data/repositories/repositories.dart';
import 'package:attendance_admin/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final AttendanceRepository attendanceRepository;
  final StudentRepository studentRepository;

  StudentBloc({this.attendanceRepository, this.studentRepository}) : super(StudentInitial());

  List<Major> _listOfMajor;

  @override
  Stream<StudentState> mapEventToState(
    StudentEvent event,
  ) async* {
    // Delete
    if (event is DeleteStudent) {
      yield* _mapDeleteStudentToState(event);
    }

    // Listing
    if (event is GetStudentList) {
      yield* _mapGetStudentListToState(event);
    }

    // Add new
    if (event is GetStudentAddNewPageData) {
      yield* _mapGetStudentAddNewPageDataToState(event);
    }

    if (event is AddNewStudentWithForm) {
      yield* _mapAddNewStudentWithFormToState(event);
    }
  }

  // Delete
  Stream<StudentState> _mapDeleteStudentToState(DeleteStudent event) async* {
    yield DeleteStudentLoading();

    try {
      final basicResponse = await studentRepository.deleteStudent(studentId: event.studentId);
      if (basicResponse.responseCode != 200) {
        yield DeleteStudentFailed(message: basicResponse.responseMessage);
      } else {
        yield DeleteStudentSuccess(message: basicResponse.responseMessage);
      }
    } catch (e) {
      yield DeleteStudentFailed(message: 'An unknown error occurred when delete student');
    }
  }

  // Listing
  Stream<StudentState> _mapGetStudentListToState(GetStudentList event) async* {
    yield StudentListingLoading();

    try {
      final _listStudent = await studentRepository.getListStudent(studentId: event.studentId);
      yield StudentListingSuccess(listStudent: _listStudent);
    } catch (e) {
      print(e);
      yield StudentListingFailed(message: 'An unknown error occurred when listing student');
    }
  }

  // Add new
  Stream<StudentState> _mapGetStudentAddNewPageDataToState(GetStudentAddNewPageData event) async* {
    yield StudentAddNewPageLoading();

    try {
      final listOfMajor = await attendanceRepository.getListOfMajor();

      if (listOfMajor != null) {
        _listOfMajor = listOfMajor;
        yield StudentAddNewPageLoadData(listMajor: listOfMajor);
      } else {
        yield StudentAddNewPageLoadDataFailure(
          message: 'Something very weird just happened',
        );
      }
    } catch (e) {
      yield StudentAddNewPageLoadDataFailure(
        message: 'An unknown error occurred when load dashboard',
      );
    }
  }

  Stream<StudentState> _mapAddNewStudentWithFormToState(AddNewStudentWithForm event) async* {
    yield StudentAddNewPageLoading();

    try {
      final basicResponse = await studentRepository.registerNewStudent(
        event.studentId,
        event.studentName,
        event.password,
        event.batch,
        event.major,
      );
      if (basicResponse.responseCode != 200) {
        yield StudentAddNewPageLoadData(listMajor: _listOfMajor);
        yield StudentAddNewFailed(message: basicResponse.responseMessage);
      } else {
        yield StudentAddNewSuccess(message: basicResponse.responseMessage);
      }
    } catch (e) {
      yield StudentAddNewFailed(message: 'An unknown error occurred when add new student');
    }
  }
}
