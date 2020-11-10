import 'dart:async';

import 'package:attendance_admin/data/repositories/attendanceRepository.dart';
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
  }

  Stream<DashboardState> _mapGetDashboardDataToState(GetDashboardData event) async* {
    yield DashboardLoading();

    try {
      final listOfRoom = await attendanceRepository.getListOfRoom();
      final listOfTime = await attendanceRepository.getListOfTime();
      final roomDetail = await attendanceRepository.getRoomDetail(event.roomName, event.date);

      if (listOfRoom != null && roomDetail != null && listOfTime != null) {
        yield DashboardLoadData(
          listRoomTime: listOfRoom,
          listTime: listOfTime,
          listDetailRoom: roomDetail,
        );
      } else {
        yield DashboardLoadDataFailure(message: 'Something very weird just happened');
      }
    } catch (e) {
      yield DashboardLoadDataFailure(message: 'An unknown error occurred when load dashboard');
    }
  }
}
