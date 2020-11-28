part of 'lecturer_bloc.dart';

abstract class LecturerState extends Equatable {
  const LecturerState();

  @override
  List<Object> get props => [];
}

class LecturerInitial extends LecturerState {}

// Delete
class DeleteLecturerLoading extends LecturerState {}

class DeleteLecturerSuccess extends LecturerState {
  final String message;

  DeleteLecturerSuccess({this.message});

  @override
  List<Object> get props => [message];
}

class DeleteLecturerFailed extends LecturerState {
  final String message;

  DeleteLecturerFailed({this.message});

  @override
  List<Object> get props => [message];
}

// Listing
class LecturerListingLoading extends LecturerState {}

class LecturerListingSuccess extends LecturerState {
  final List<Lecturer> listLecturer;

  LecturerListingSuccess({this.listLecturer});

  @override
  List<Object> get props => [listLecturer];
}

class LecturerListingFailed extends LecturerState {
  final String message;

  LecturerListingFailed({this.message});

  @override
  List<Object> get props => [message];
}

// Add New
class LecturerAddNewPageLoading extends LecturerState {}

class LecturerAddNewSuccess extends LecturerState {
  final String message;

  LecturerAddNewSuccess({this.message});

  @override
  List<Object> get props => [message];
}

class LecturerAddNewFailed extends LecturerState {
  final String message;

  LecturerAddNewFailed({this.message});

  @override
  List<Object> get props => [message];
}
