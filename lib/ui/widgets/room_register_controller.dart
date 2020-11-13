import 'package:attendance_admin/models/enrolled_student.dart';
import 'package:flutter/material.dart';

class RoomRegister extends StatefulWidget {
  final String time;
  final String subject;
  final List<Enrolled> enrolled;
  final String lecturer;
  final bool status;

  RoomRegister({this.time, this.subject, this.enrolled, this.lecturer, this.status});

  @override
  _RoomRegisterState createState() => _RoomRegisterState();
}

class _RoomRegisterState extends State<RoomRegister> {
  String _time;
  String _subject;
  String _lecturer;
  bool _status;
  List<Enrolled> listChips = <Enrolled>[];

  final timeInputController = TextEditingController();
  final subjectInputController = TextEditingController();
  final lecturerInputController = TextEditingController();
  final statusInputController = TextEditingController();
  final studentInputController = TextEditingController();

  @override
  void initState() {
    _time = widget.time;
    _subject = widget.subject;
    _lecturer = widget.lecturer;
    _status = widget.status;
    listChips = widget.enrolled;
    super.initState();
  }

  @override
  void dispose() {
    timeInputController.dispose();
    subjectInputController.dispose();
    lecturerInputController.dispose();
    statusInputController.dispose();
    studentInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                controller: subjectInputController,
                onSubmitted: (value) {
                  setState(() {
                    subjectInputController.text = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: _subject,
                  isDense: true,
                ),
                keyboardType: TextInputType.text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                controller: lecturerInputController,
                onSubmitted: (value) {
                  setState(() {
                    lecturerInputController.text = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: _lecturer,
                  isDense: true,
                ),
                keyboardType: TextInputType.text,
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
          ],
        ),
      ),
    );
  }
}
