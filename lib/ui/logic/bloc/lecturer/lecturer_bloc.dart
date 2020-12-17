import 'dart:async';

import 'package:attendance_admin/data/repositories/repositories.dart';
import 'package:attendance_admin/models/lecturer.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'lecturer_event.dart';
part 'lecturer_state.dart';

class LecturerBloc extends Bloc<LecturerEvent, LecturerState> {
  final LecturerRepository lecturerRepository;

  LecturerBloc({this.lecturerRepository}) : super(LecturerInitial());

  @override
  Stream<LecturerState> mapEventToState(
    LecturerEvent event,
  ) async* {
    // Delete
    if (event is DeleteLecturer) {
      yield* _mapDeleteLecturerToState(event);
    }

    // Listing
    if (event is GetLecturerList) {
      yield* _mapGetLecturerListToState(event);
    }

    // Add new
    if (event is AddNewLecturerWithForm) {
      yield* _mapAddNewLecturerWithFormToState(event);
    }
  }

  // Delete
  Stream<LecturerState> _mapDeleteLecturerToState(DeleteLecturer event) async* {
    yield DeleteLecturerLoading();

    try {
      final basicResponse = await lecturerRepository.deleteLecturer(
        lecturerEmail: event.lecturerEmail,
      );
      if (basicResponse.responseCode != 200) {
        yield DeleteLecturerFailed(message: basicResponse.responseMessage);
      } else {
        yield DeleteLecturerSuccess(message: basicResponse.responseMessage);
      }
    } catch (e) {
      yield DeleteLecturerFailed(message: 'An unknown error occurred when delete lecturer');
    }
  }

  // Listing
  Stream<LecturerState> _mapGetLecturerListToState(GetLecturerList event) async* {
    yield LecturerListingLoading();

    try {
      final _listLecturer = await lecturerRepository.getListLecturer(
        lecturerName: event.lecturerName,
      );
      yield LecturerListingSuccess(listLecturer: _listLecturer);
    } catch (e) {
      print(e);
      yield LecturerListingFailed(message: 'An unknown error occurred when listing lecturer');
    }
  }

  // Add New
  Stream<LecturerState> _mapAddNewLecturerWithFormToState(AddNewLecturerWithForm event) async* {
    yield LecturerAddNewPageLoading();

    try {
      final basicResponse = await lecturerRepository.registerNewLecturer(
        event.lecturerEmail,
        event.lecturerName,
        event.password,
      );
      if (basicResponse.responseCode != 200) {
        yield LecturerAddNewFailed(message: basicResponse.responseMessage);
      } else {
        yield LecturerAddNewSuccess(message: basicResponse.responseMessage);
      }
    } catch (e) {
      yield LecturerAddNewFailed(message: 'An unknown error occurred when add new lecturer');
    }
  }
}
