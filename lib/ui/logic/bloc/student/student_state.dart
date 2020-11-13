part of 'student_bloc.dart';

abstract class StudentState extends Equatable {
  const StudentState();

  @override
  List<Object> get props => [];
}

class StudentInitial extends StudentState {}

class StudentAddNewPageLoading extends StudentState {}

class StudentAddNewSuccess extends StudentState {
  final String message;

  StudentAddNewSuccess({this.message});

  @override
  List<Object> get props => [message];
}

class StudentAddNewFailed extends StudentState {
  final String message;

  StudentAddNewFailed({this.message});

  @override
  List<Object> get props => [message];
}

class StudentAddNewPageLoadData extends StudentState {
  final List<Major> listMajor;

  StudentAddNewPageLoadData({this.listMajor});

  @override
  List<Object> get props => [listMajor];
}

class StudentAddNewPageLoadDataFailure extends StudentState {
  final String message;

  StudentAddNewPageLoadDataFailure({this.message});

  @override
  List<Object> get props => [message];
}
