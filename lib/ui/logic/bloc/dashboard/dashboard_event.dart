part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

class GetDashboardData extends DashboardEvent {
  final List<Room> listRoomTime;
  final List<String> listTime;

  final String roomName;
  final String date;

  GetDashboardData({this.listRoomTime, this.listTime, this.roomName, this.date});

  @override
  List<Object> get props => [listRoomTime, listTime, roomName, date];
}
