import 'dart:async';

import 'package:attendance_admin/data/repositories/repositories.dart';
import 'package:attendance_admin/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final AttendanceRepository attendanceRepository;

  DashboardBloc({this.attendanceRepository}) : super(DashboardInitial());

  @override
  Stream<DashboardState> mapEventToState(
    DashboardEvent event,
  ) async* {
    if (event is GetDashboardData) {
      yield* _mapGetDashboardDataToState(event);
    }
    if (event is UpdateRoomData) {
      yield* _mapUpdateRoomData(event);
    }
  }

  Stream<DashboardState> _mapGetDashboardDataToState(GetDashboardData event) async* {
    yield DashboardLoading();

    try {
      final listOfRoom = await attendanceRepository.getListOfRoom();
      final listOfTime = await attendanceRepository.getListOfTime();
      final basicResponse = await attendanceRepository.getRoomDetail(event.roomName, event.date);

      if (listOfRoom != null && basicResponse.responseCode == 200 && listOfTime != null) {
        yield DashboardLoadData(
          listRoomTime: listOfRoom,
          listTime: listOfTime,
          detailRoom: RoomDetail.fromJson(basicResponse.data),
        );
      } else {
        yield DashboardLoadDataFailure(message: 'Something very weird just happened');
      }
    } catch (e) {
      yield DashboardLoadDataFailure(message: 'An unknown error occurred when load dashboard');
    }
  }

  Stream<DashboardState> _mapUpdateRoomData(UpdateRoomData event) async* {
    yield DashboardLoading();

    try {
      final roomUpdate = await attendanceRepository.updateRoomData(event.time, event.roomName, event.date, event.updatedTime);

      if (roomUpdate.responseCode == 200) {
        yield DashboardLoadDataSuccess(message: 'Data updated');
      } else {
        yield DashboardLoadDataFailure(message: 'Something very weird just happened');
      }
    } catch (e) {
      yield DashboardLoadDataFailure(message: 'An unknown error occurred when update data');
    }
  }
}
