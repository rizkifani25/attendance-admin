import 'package:attendance_admin/constant/Constant.dart';
import 'package:attendance_admin/models/models.dart';
import 'package:attendance_admin/ui/logic/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead_web/flutter_typeahead.dart';

class RoomRegister extends StatefulWidget {
  final String time;
  final String subject;
  final List<Enrolled> enrolled;
  final Lecturer lecturer;
  final RoomStatus status;
  final String roomName;
  final String date;

  RoomRegister({
    this.time,
    this.subject,
    this.enrolled,
    this.lecturer,
    this.status,
    this.roomName,
    this.date,
  });

  @override
  _RoomRegisterState createState() => _RoomRegisterState();
}

class _RoomRegisterState extends State<RoomRegister> {
  String _time;
  String _subject;
  Lecturer _lecturer;
  RoomStatus _status;
  String _roomName;
  String _selectedStatus;
  String _date;
  List<Enrolled> listChips = <Enrolled>[];
  static List<Lecturer> _listLecturer = [];
  static List<Student> _listStudent = [];

  final _subjectInputController = TextEditingController();
  final TextEditingController _typeAheadLecturerController = TextEditingController();
  final TextEditingController _typeAheadStudentController = TextEditingController();

  @override
  void initState() {
    _selectedStatus = widget.status.statusMessage;
    _time = widget.time;
    _subject = widget.subject;
    _lecturer = widget.lecturer;
    _status = widget.status;
    _roomName = widget.roomName;
    _date = widget.date;
    listChips = widget.enrolled;
    _subjectInputController.text = widget.subject;
    _typeAheadLecturerController.text = widget.lecturer.lecturerName;
    BlocProvider.of<LecturerBloc>(context).add(GetLecturerList());
    BlocProvider.of<StudentBloc>(context).add(GetStudentList());
    super.initState();
  }

  @override
  void dispose() {
    _subjectInputController.dispose();
    _typeAheadLecturerController.dispose();
    _typeAheadStudentController.dispose();
    super.dispose();
  }

  static List<Lecturer> _getSuggestionForLecturer(String query) {
    List<Lecturer> matches = [];
    matches.addAll(_listLecturer);
    matches.retainWhere((Lecturer s) => s.lecturerName.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  static List<Student> _getSuggestionForStudent(String query) {
    List<Student> matches = [];
    matches.addAll(_listStudent);
    matches.retainWhere((Student s) => s.studentId.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  _handleUpdateButton() {
    Time updateTime = new Time(
      subject: _subjectInputController.text.isNotEmpty ? _subjectInputController.text : '-',
      lecturer: _typeAheadLecturerController.text.isNotEmpty ? _lecturer : new Lecturer(lecturerName: '-', lecturerEmail: '-', password: '-', historyRoom: []),
      enrolled: listChips,
      status: _selectedStatus == 'Available' ? new RoomStatus(status: false, statusMessage: 'Available') : new RoomStatus(status: true, statusMessage: _selectedStatus),
    );
    BlocProvider.of<DashboardBloc>(context).add(
      UpdateRoomData(
        date: _date,
        time: _time == '07.30 - 09.30'
            ? 'time1'
            : _time == '10.00 - 12.00'
                ? 'time2'
                : _time == '12.30 - 14.30'
                    ? 'time3'
                    : 'time4',
        roomName: _roomName,
        updatedTime: updateTime,
      ),
    );
  }

  _handleAddStudentToListEnrolled(Student student) {
    setState(() {
      listChips.add(
        Enrolled(
          student: student,
          statusAttendance: new StatusAttendance(
            byDistance: '-',
            byPhoto: '-',
            byTime: '-',
          ),
          attendStudent: new AttendStudent(
            image: '-',
            time: '-',
            positionStudent: new PositionStudent(latitude: 0.0, longitude: 0.0),
            distance: 0.0,
          ),
          outStudent: new OutStudent(
            image: '-',
            time: '-',
            positionStudent: new PositionStudent(latitude: 0.0, longitude: 0.0),
            distance: 0.0,
          ),
          permission: new Permission(statusPermission: '-', reason: '-'),
        ),
      );
    });
  }

  _handleAddLecturerToClass(Lecturer lecturer) {
    setState(() {
      _lecturer = lecturer;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 500,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Text(
                    _roomName + ' // ' + _date + ' // ' + _time,
                    style: TextStyle(
                      fontSize: 24,
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: DropdownButton(
                  hint: Text('Select Room'),
                  value: _selectedStatus,
                  items: RoomStatus().getRoomStatusList().map((e) {
                    return DropdownMenuItem(
                      child: Text(e.statusMessage),
                      value: e.statusMessage,
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedStatus = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: TextField(
                  controller: _subjectInputController,
                  decoration: InputDecoration(
                    labelText: 'Subject',
                    border: OutlineInputBorder(),
                    hintText: 'Input subject',
                    isDense: true,
                  ),
                  keyboardType: TextInputType.text,
                  onSubmitted: (value) {
                    setState(() {
                      _subject = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: BlocBuilder<LecturerBloc, LecturerState>(builder: (context, state) {
                  if (state is LecturerListingSuccess) {
                    _listLecturer = state.listLecturer;
                    return ListTile(
                      title: TypeAheadField(
                        textFieldConfiguration: TextFieldConfiguration(
                          decoration: InputDecoration(
                            labelText: 'Lecturer Name',
                            border: OutlineInputBorder(),
                          ),
                          controller: _typeAheadLecturerController,
                        ),
                        suggestionsCallback: (pattern) {
                          return _getSuggestionForLecturer(pattern);
                        },
                        transitionBuilder: (context, suggestionsBox, controller) {
                          return suggestionsBox;
                        },
                        itemBuilder: (context, Lecturer suggestion) {
                          return Container(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      suggestion.lecturerName,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(50.0, 10, 10, 10),
                                  child: Text(
                                    suggestion.lecturerEmail,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                        onSuggestionSelected: (Lecturer suggestion) {
                          _handleAddLecturerToClass(suggestion);
                          _typeAheadLecturerController.text = suggestion.lecturerName;
                        },
                      ),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  );
                }),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: BlocBuilder<StudentBloc, StudentState>(builder: (context, state) {
                  if (state is StudentListingSuccess) {
                    _listStudent = state.listStudent;
                    return ListTile(
                      title: TypeAheadField(
                        textFieldConfiguration: TextFieldConfiguration(
                          decoration: InputDecoration(
                            labelText: 'Student Id',
                            border: OutlineInputBorder(),
                          ),
                          controller: _typeAheadStudentController,
                        ),
                        suggestionsCallback: (pattern) {
                          return _getSuggestionForStudent(pattern);
                        },
                        transitionBuilder: (context, suggestionsBox, controller) {
                          return suggestionsBox;
                        },
                        itemBuilder: (context, Student suggestion) {
                          return Container(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      suggestion.studentId,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(50.0, 10, 10, 10),
                                  child: Text(
                                    suggestion.studentName,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                        onSuggestionSelected: (Student suggestion) {
                          _handleAddStudentToListEnrolled(suggestion);
                          _typeAheadStudentController.text = suggestion.studentId;
                        },
                      ),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  );
                }),
              ),
              Wrap(
                children: listChips.map((e) {
                  return Padding(
                    padding: EdgeInsets.all(5),
                    child: InputChip(
                      avatar: CircleAvatar(
                        child: Icon(Icons.account_circle),
                      ),
                      label: Text(e.student.studentId),
                      onDeleted: () => setState(
                        () => listChips.remove(e),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: RaisedButton(
                    color: greenColor,
                    textColor: textColor,
                    padding: const EdgeInsets.all(10),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(8.0),
                    ),
                    child: Text('UPDATE'),
                    onPressed: () => _handleUpdateButton(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
