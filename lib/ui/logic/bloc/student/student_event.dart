part of 'student_bloc.dart';

abstract class StudentEvent extends Equatable {
  const StudentEvent();

  @override
  List<Object> get props => [];
}

class GetStudentAddNewPageData extends StudentEvent {
  final List<Major> listMajor;

  GetStudentAddNewPageData({this.listMajor});

  @override
  List<Object> get props => [listMajor];
}

class AddNewStudentWithForm extends StudentEvent {
  final String studentId;
  final String studentName;
  final String password;
  final String batch;
  final String major;

  AddNewStudentWithForm({
    @required this.studentId,
    @required this.studentName,
    @required this.password,
    @required this.batch,
    @required this.major,
  });

  @override
  List<Object> get props => [studentId, studentName, password, batch, major];
}
