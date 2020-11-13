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

  StudentBloc({this.attendanceRepository}) : super(StudentInitial());

  List<Major> _listOfMajor;

  @override
  Stream<StudentState> mapEventToState(
    StudentEvent event,
  ) async* {
    if (event is GetStudentAddNewPageData) {
      yield* _mapGetStudentAddNewPageDataToState(event);
    }
    if (event is AddNewStudentWithForm) {
      yield* _mapAddNewStudentWithFormToState(event);
    }
  }

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
      final basicResponse = await attendanceRepository.registerNewStudent(
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
