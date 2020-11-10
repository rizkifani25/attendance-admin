part of 'dashboard_bloc.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardDataEmpty extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoadData extends DashboardState {
  final List<Room> listRoomTime;
  final List<Time> listDetailRoom;
  final List<String> listTime;

  DashboardLoadData({this.listRoomTime, this.listDetailRoom, this.listTime});

  @override
  List<Object> get props => [listRoomTime, listDetailRoom, listTime];
}

class DashboardLoadDataFailure extends DashboardState {
  final String message;

  DashboardLoadDataFailure({this.message});

  @override
  List<Object> get props => [message];
}
