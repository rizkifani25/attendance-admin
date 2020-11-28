import 'dart:async';
import 'dart:convert';

import 'package:attendance_admin/constant/Constant.dart';
import 'package:attendance_admin/data/dataproviders/dataproviders.dart';
import 'package:attendance_admin/data/repositories/repositories.dart';
import 'package:attendance_admin/models/models.dart';
import 'package:attendance_admin/ui/logic/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead_web/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class RoomRegister extends StatefulWidget {
  final String time;
  final String subject;
  final List<Enrolled> enrolled;
  final String lecturer;
  final bool status;
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
  String _lecturer;
  bool _status;
  String _roomName;
  String _date;
  String _selectedLecturer;
  List<Enrolled> listChips = <Enrolled>[];
  bool _onValidateStudentProcess;
  bool _onValidateLecturerProcess;
  static List<Lecturer> _listLecturer = [];
  static List<Enrolled> _listStudent = [];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _typeAheadController = TextEditingController();
  final subjectInputController = TextEditingController();
  final lecturerInputController = TextEditingController();
  final studentInputController = TextEditingController();

  @override
  void initState() {
    _time = widget.time;
    _subject = widget.subject;
    _lecturer = widget.lecturer;
    _status = widget.status;
    _roomName = widget.roomName;
    _date = widget.date;
    _onValidateStudentProcess = false;
    _onValidateLecturerProcess = false;
    listChips = widget.enrolled;
    BlocProvider.of<LecturerBloc>(context).add(GetLecturerList());
    super.initState();
  }

  @override
  void dispose() {
    subjectInputController.dispose();
    lecturerInputController.dispose();
    studentInputController.dispose();
    super.dispose();
  }

  static List<Lecturer> _getSuggestionForLecturer(String query) {
    List<Lecturer> matches = [];
    matches.addAll(_listLecturer);
    matches.retainWhere((Lecturer s) => s.lecturerName.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  static List<Enrolled> _getSuggestionForStudent(String query) {
    List<Enrolled> matches = [];
    matches.addAll(_listStudent);
    matches.retainWhere((Enrolled s) => s.studentId.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  _handleUpdateButton() {
    Time updateTime = new Time(
      subject: subjectInputController.text,
      lecturer: lecturerInputController.text,
      enrolled: listChips,
      status: subjectInputController.text != '' ||
              lecturerInputController.text != '' ||
              listChips.isNotEmpty
          ? true
          : false,
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

  _handleValidateStudentId(String studentId) {
    setState(() {
      _onValidateStudentProcess = true;
      listChips.add(
        Enrolled(
          studentId: studentId,
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
        ),
      );
    });
    BlocProvider.of<StudentBloc>(context).add(GetStudentList(studentId: studentId));
  }

  _handleValidateLecturerName(String lecturerName) {
    setState(() {
      _onValidateLecturerProcess = true;
      _lecturer = lecturerName;
    });
    BlocProvider.of<LecturerBloc>(context).add(GetLecturerList(lecturerName: lecturerName));
  }

  _handleSuggestionForLecturer(String pattern) {
    print('masuk sini');
    List<String> lecturerName;
    LecturerRepository(
      attendanceApi: AttendanceApi(),
    )
        .getListLecturer(lecturerName: pattern)
        .then((value) => value.map((e) => lecturerName.add(e.lecturerName)));
    print(lecturerName.length);
    return lecturerName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
              padding: const EdgeInsets.all(15),
              child: TextField(
                controller: subjectInputController,
                decoration: InputDecoration(
                  labelText: 'Subject',
                  hintText: _subject == '' ? 'Input subject' : _subject,
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
                        decoration: InputDecoration(labelText: 'Lecturer Name'),
                        controller: this._typeAheadController,
                      ),
                      suggestionsCallback: (pattern) {
                        return _getSuggestionForLecturer(pattern);
                      },
                      transitionBuilder: (context, suggestionsBox, controller) {
                        return suggestionsBox;
                      },
                      itemBuilder: (context, Lecturer suggestion) {
                        return Card(
                          elevation: 10,
                          child: Row(
                            children: <Widget>[
                              // Padding(
                              //   padding: EdgeInsets.fromLTRB(3, 5, 10, 2),
                              //   child: ClipRRect(
                              //     borderRadius: BorderRadius.circular(30.0),
                              //     child: Image(
                              //       image: NetworkImage(suggestion.url, scale: 3),
                              //     ),
                              //   ),
                              // ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    suggestion.lecturerName,
                                    style: TextStyle(color: Colors.black, fontSize: 15),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(50.0, 10, 10, 10),
                                child: Text(
                                  suggestion.lecturerEmail,
                                  style: TextStyle(color: Colors.black, fontSize: 15),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      onSuggestionSelected: (suggestion) {
                        this._typeAheadController.text = suggestion;
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
              padding: const EdgeInsets.all(15),
              child: TextField(
                controller: studentInputController,
                onSubmitted: (value) {
                  _handleValidateStudentId(value);
                },
                decoration: InputDecoration(
                  hintText: 'Input a student id',
                  isDense: true,
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            BlocBuilder<StudentBloc, StudentState>(
              builder: (context, state) {
                if (state is StudentListingSuccess) {
                  if (state.listStudent.isEmpty && _onValidateStudentProcess) {
                    Fluttertoast.showToast(
                      webBgColor: "linear-gradient(to right, #c62828, #d32f2f)",
                      msg: 'Student id not registered.',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: redColor,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                    listChips.removeLast();
                  }
                  return Wrap(
                    children: listChips.map((e) {
                      return Padding(
                        padding: EdgeInsets.all(5),
                        child: InputChip(
                          avatar: CircleAvatar(
                            child: Icon(Icons.account_circle),
                          ),
                          label: Text(e.studentId),
                          onDeleted: () => setState(() => listChips.remove(e)),
                        ),
                      );
                    }).toList(),
                  );
                }
                return Wrap(
                  children: listChips.map((e) {
                    return Padding(
                      padding: EdgeInsets.all(5),
                      child: InputChip(
                        avatar: CircleAvatar(
                          child: Icon(Icons.account_circle),
                        ),
                        label: Text(e.studentId),
                        onDeleted: () => setState(() => listChips.remove(e)),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: RaisedButton(
                color: greenColor,
                textColor: textColor,
                padding: const EdgeInsets.all(16),
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(8.0)),
                child: Text('UPDATE'),
                onPressed: () => _handleUpdateButton(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Padding(
//               padding: const EdgeInsets.all(15),
//               child: TypeAheadField(
//                 textFieldConfiguration: TextFieldConfiguration(
//                     autofocus: true,
//                     style: DefaultTextStyle.of(context).style.copyWith(fontStyle: FontStyle.italic),
//                     decoration: InputDecoration(border: OutlineInputBorder())),
//                 suggestionsCallback: (pattern) async {
//                   Completer<List<String>> completer = new Completer();
//                   completer.complete(<String>["cobalt", "copper"]);
//                   return completer.future;
//                   // return await LecturerRepository(
//                   //   attendanceApi: AttendanceApi(),
//                   // ).getListLecturer(lecturerName: pattern);
//                 },
//                 itemBuilder: (context, suggestion) {
//                   print(suggestion);
//                   return Container(
//                     color: primaryColor,
//                     child: ListTile(
//                       leading: Icon(Icons.person),
//                       title: Text(suggestion),
//                       // subtitle: Text("suggestion['lecturer_email']"),
//                     ),
//                   );
//                 },
//                 onSuggestionSelected: (suggestion) {
//                   // Navigator.of(context).push(MaterialPageRoute(
//                   //   builder: (context) => ProductPage(product: suggestion)
//                   // ));
//                 },
//               ),
//             ),

// @override
// Widget build(BuildContext context) {
//   return Container(
//     child: Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Center(
//             child: Text(
//               _roomName + ' // ' + _date + ' // ' + _time,
//               style: TextStyle(
//                 fontSize: 24,
//                 color: primaryColor,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(15),
//             child: Text(
//               'Subject',
//               style: TextStyle(
//                 fontSize: 24,
//                 color: primaryColor,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(15),
//             child: TextField(
//               controller: subjectInputController,
//               onSubmitted: (value) {
//                 setState(() {
//                   _subject = value;
//                 });
//               },
//               decoration: InputDecoration(
//                 hintText: _subject == '' ? 'Input subject' : _subject,
//                 isDense: true,
//               ),
//               keyboardType: TextInputType.text,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(15),
//             child: Text(
//               'Lecturer',
//               style: TextStyle(
//                 fontSize: 24,
//                 color: primaryColor,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(15),
//             child: TextField(
//               controller: lecturerInputController,
//               onSubmitted: (value) {
//                 _handleValidateLecturerName(value);
//               },
//               decoration: InputDecoration(
//                 hintText: _lecturer == '' ? 'Input a lecturer name' : _lecturer,
//                 isDense: true,
//               ),
//               keyboardType: TextInputType.text,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(15),
//             child: TypeAheadFormField(
//               textFieldConfiguration: TextFieldConfiguration(
//                 controller: this._typeAheadController,
//                 decoration: InputDecoration(
//                   labelText: 'Lecturer Name',
//                 ),
//               ),
//               suggestionsCallback: (pattern) {
//                 return _handleSuggestionForLecturer(pattern);
//               },
//               itemBuilder: (context, Lecturer suggestion) {
//                 return ListTile(
//                   title: Text(suggestion.lecturerName),
//                 );
//               },
//               transitionBuilder: (context, suggestionsBox, controller) {
//                 return suggestionsBox;
//               },
//               onSuggestionSelected: (suggestion) {
//                 this._typeAheadController.text = suggestion;
//               },
//               validator: (value) {
//                 if (value.isEmpty) {
//                   return 'Please select a lecturer name';
//                 }
//                 return '';
//               },
//               onSaved: (value) => this._selectedLecturer = value,
//             ),
//           ),
// BlocBuilder<LecturerBloc, LecturerState>(builder: (context, state) {
//   if (state is LecturerListingSuccess) {
//     if (state.listLecturer.isEmpty && _onValidateLecturerProcess) {
//       Fluttertoast.showToast(
//         webBgColor: "linear-gradient(to right, #c62828, #d32f2f)",
//         msg: 'Lecturer name not registered.',
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.CENTER,
//         timeInSecForIosWeb: 1,
//         backgroundColor: redColor,
//         textColor: Colors.white,
//         fontSize: 16.0,
//       );
//       return Container();
//     }
//     return Container();
//   }
//   return Container();
// }),
// Padding(
//   padding: const EdgeInsets.all(15),
//   child: Text(
//     'Students',
//     style: TextStyle(
//       fontSize: 24,
//       color: primaryColor,
//     ),
//   ),
// ),
// Padding(
//   padding: const EdgeInsets.all(15),
//   child: TextField(
//     controller: studentInputController,
//     onSubmitted: (value) {
//       _handleValidateStudentId(value);
//     },
//     decoration: InputDecoration(
//       hintText: 'Input a student id',
//       isDense: true,
//     ),
//     keyboardType: TextInputType.emailAddress,
//   ),
// ),
// BlocBuilder<StudentBloc, StudentState>(
//   builder: (context, state) {
//     if (state is StudentListingSuccess) {
//       if (state.listStudent.isEmpty && _onValidateStudentProcess) {
//         Fluttertoast.showToast(
//           webBgColor: "linear-gradient(to right, #c62828, #d32f2f)",
//           msg: 'Student id not registered.',
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.CENTER,
//           timeInSecForIosWeb: 1,
//           backgroundColor: redColor,
//           textColor: Colors.white,
//           fontSize: 16.0,
//         );
//         listChips.removeLast();
//       }
//       return Wrap(
//         children: listChips.map((e) {
//           return Padding(
//             padding: EdgeInsets.all(5),
//             child: InputChip(
//               avatar: CircleAvatar(
//                 child: Icon(Icons.account_circle),
//               ),
//               label: Text(e.studentId),
//               onDeleted: () => setState(() => listChips.remove(e)),
//             ),
//           );
//         }).toList(),
//       );
//     }
//     return Wrap(
//       children: listChips.map((e) {
//         return Padding(
//           padding: EdgeInsets.all(5),
//           child: InputChip(
//             avatar: CircleAvatar(
//               child: Icon(Icons.account_circle),
//             ),
//             label: Text(e.studentId),
//             onDeleted: () => setState(() => listChips.remove(e)),
//           ),
//         );
//       }).toList(),
//     );
//   },
// ),
// SizedBox(
//   height: 20,
// ),
// Padding(
//   padding: const EdgeInsets.all(10),
//   child: RaisedButton(
//     color: greenColor,
//     textColor: textColor,
//     padding: const EdgeInsets.all(16),
//     shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(8.0)),
//     child: Text('UPDATE'),
//     onPressed: () => _handleUpdateButton(),
//   ),
// ),
//         ],
//       ),
//     ),
//   );
// }
