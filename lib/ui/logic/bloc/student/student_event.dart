part of 'student_bloc.dart';

abstract class StudentEvent extends Equatable {
  const StudentEvent();

  @override
  List<Object> get props => [];
}

// Delete
class DeleteStudent extends StudentEvent {
  final String studentId;

  DeleteStudent({this.studentId});

  @override
  List<Object> get props => [studentId];
}

// Listing
class GetStudentList extends StudentEvent {
  final String studentId;

  GetStudentList({this.studentId});

  @override
  List<Object> get props => [studentId];
}

// Add new
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
