part of 'lecturer_bloc.dart';

abstract class LecturerEvent extends Equatable {
  const LecturerEvent();

  @override
  List<Object> get props => [];
}

// Delete
class DeleteLecturer extends LecturerEvent {
  final String lecturerEmail;

  DeleteLecturer({this.lecturerEmail});

  @override
  List<Object> get props => [lecturerEmail];
}

// Listing
class GetLecturerList extends LecturerEvent {
  final String lecturerName;

  GetLecturerList({this.lecturerName});

  @override
  List<Object> get props => [lecturerName];
}

// Add New
class AddNewLecturerWithForm extends LecturerEvent {
  final String lecturerEmail;
  final String lecturerName;
  final String password;

  AddNewLecturerWithForm({
    @required this.lecturerEmail,
    @required this.lecturerName,
    @required this.password,
  });

  @override
  List<Object> get props => [lecturerEmail, lecturerName, password];
}
