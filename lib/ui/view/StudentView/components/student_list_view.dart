import 'package:attendance_admin/constant/Constant.dart';
import 'package:attendance_admin/models/models.dart';
import 'package:attendance_admin/ui/logic/bloc/bloc.dart';
import 'package:attendance_admin/ui/view/Widgets/widgets.dart';
import 'package:attendance_admin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'student_view_components.dart';

class ListStudentView extends StatefulWidget {
  @override
  _ListStudentViewState createState() => _ListStudentViewState();
}

class _ListStudentViewState extends State<ListStudentView> {
  final _debouncer = Debouncer(milliseconds: 500);

  @override
  void initState() {
    BlocProvider.of<StudentBloc>(context).add(GetStudentList());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _handleShowPanelAddNewStudentButton(BuildContext context) {
    BlocProvider.of<StudentBloc>(context).add(GetStudentAddNewPageData());
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialogBox(
          children: [
            StudentAddNew(),
          ],
        );
      },
    ).then((value) => BlocProvider.of<StudentBloc>(context).add(GetStudentList()));
  }

  _handleDeleteButton(String studentId) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialogBox(
          children: [
            Text(
              'Delete student ' + studentId + '?',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FlatButton(
                onPressed: () {
                  BlocProvider.of<StudentBloc>(context).add(DeleteStudent(studentId: studentId));
                  BlocProvider.of<StudentBloc>(context).add(GetStudentList());
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Yes',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Flex(
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Container(
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(5),
                  hintText: 'Filter by student id',
                ),
                onChanged: (string) {
                  _debouncer.run(() {
                    BlocProvider.of<StudentBloc>(context).add(GetStudentList(studentId: string));
                  });
                },
              ),
            ),
          ),
          Card(
            child: Container(
              height: MediaQuery.of(context).size.height - 150,
              width: MediaQuery.of(context).size.width - 100,
              child: Scaffold(
                body: BlocBuilder<StudentBloc, StudentState>(builder: (context, state) {
                  if (state is StudentListingSuccess) {
                    return _tableListStudent(state.listStudent);
                  }
                  if (state is StudentListingFailed) {
                    ToastNotification().showToast(message: state.message, color: redColor);
                  }
                  return WidgetLoadingIndicator(color: primaryColor);
                }),
                floatingActionButton: FloatingActionButton(
                  tooltip: 'Add New Student',
                  onPressed: () {
                    _handleShowPanelAddNewStudentButton(context);
                  },
                  child: Icon(Icons.person_add_alt_1_rounded),
                  backgroundColor: greenColor,
                ),
                floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
              ),
            ),
          ),
          Container(
            child: BlocBuilder<StudentBloc, StudentState>(
              builder: (context, state) {
                if (state is DeleteStudentSuccess) {
                  return ToastNotification().showToast(message: state.message);
                }
                if (state is DeleteStudentFailed) {
                  return ToastNotification().showToast(message: state.message, color: redColor);
                }
                return Text('');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _tableListStudent(List<Student> listStudent) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: <DataColumn>[DataColumn(label: Text('Student ID')), DataColumn(label: Text('Name')), DataColumn(label: Text('Batch')), DataColumn(label: Text('Major')), DataColumn(label: Text('History Room')), DataColumn(label: Text('Actions'))],
        rows: listStudent
            .map(
              (e) => DataRow(
                cells: <DataCell>[
                  DataCell(Text(e.studentId)),
                  DataCell(Text(e.studentName)),
                  DataCell(Text(e.batch)),
                  DataCell(Text(e.major)),
                  DataCell(Text(e.historyRoom.length.toString())),
                  DataCell(Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: redColor,
                        ),
                        onPressed: () {
                          return _handleDeleteButton(e.studentId);
                        },
                      ),
                    ],
                  ))
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
