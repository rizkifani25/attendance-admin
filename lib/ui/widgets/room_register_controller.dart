import 'package:attendance_admin/constant/Constant.dart';
import 'package:attendance_admin/models/enrolled_student.dart';
import 'package:attendance_admin/models/models.dart';
import 'package:attendance_admin/ui/logic/bloc/dashboard/dashboard_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  List<Enrolled> listChips = <Enrolled>[];

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
    listChips = widget.enrolled;
    super.initState();
  }

  @override
  void dispose() {
    subjectInputController.dispose();
    lecturerInputController.dispose();
    studentInputController.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                _roomName + ' // ' + _date + ' // ' + _time,
                style: TextStyle(
                  fontSize: 24,
                  color: primaryColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                'Subject',
                style: TextStyle(
                  fontSize: 24,
                  color: primaryColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                controller: subjectInputController,
                onSubmitted: (value) {
                  setState(() {
                    _subject = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: _subject == '' ? 'Input subject' : _subject,
                  isDense: true,
                ),
                keyboardType: TextInputType.text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                'Lecturer',
                style: TextStyle(
                  fontSize: 24,
                  color: primaryColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                controller: lecturerInputController,
                onSubmitted: (value) {
                  setState(() {
                    _lecturer = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: _lecturer == '' ? 'Input a lecturer name' : _lecturer,
                  isDense: true,
                ),
                keyboardType: TextInputType.text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                'Students',
                style: TextStyle(
                  fontSize: 24,
                  color: primaryColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                controller: studentInputController,
                onSubmitted: (value) {
                  setState(() {
                    studentInputController.text = '';
                    listChips.add(Enrolled(studentId: value, status: 1));
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Input a student id',
                  isDense: true,
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            Wrap(
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
