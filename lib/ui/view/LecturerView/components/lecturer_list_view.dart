import 'package:attendance_admin/constant/Constant.dart';
import 'package:attendance_admin/models/models.dart';
import 'package:attendance_admin/ui/logic/bloc/bloc.dart';
import 'package:attendance_admin/ui/view/LecturerView/components/lecturer_view_components.dart';
import 'package:attendance_admin/ui/view/Widgets/widgets.dart';
import 'package:attendance_admin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListLecturerView extends StatefulWidget {
  @override
  _ListLecturerViewState createState() => _ListLecturerViewState();
}

class _ListLecturerViewState extends State<ListLecturerView> {
  final _debouncer = Debouncer(milliseconds: 500);

  @override
  void initState() {
    BlocProvider.of<LecturerBloc>(context).add(GetLecturerList());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _handleShowPanelAddNewStudentButton(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialogBox(
          children: [
            LecturerAddnew(),
          ],
        );
      },
    ).then((value) => BlocProvider.of<LecturerBloc>(context).add(GetLecturerList()));
  }

  _handleDeleteButton(String lecturerEmail) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialogBox(
          children: [
            Text(
              'Delete lecturer ' + lecturerEmail + '?',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FlatButton(
                onPressed: () {
                  BlocProvider.of<LecturerBloc>(context).add(DeleteLecturer(lecturerEmail: lecturerEmail));
                  BlocProvider.of<LecturerBloc>(context).add(GetLecturerList());
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
                  hintText: 'Filter by lecturer name',
                ),
                onChanged: (string) {
                  _debouncer.run(() {
                    BlocProvider.of<LecturerBloc>(context).add(GetLecturerList(lecturerName: string));
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
                body: BlocBuilder<LecturerBloc, LecturerState>(
                  builder: (context, state) {
                    if (state is LecturerListingSuccess) {
                      return _tableListLecturer(state.listLecturer);
                    }
                    if (state is LecturerListingFailed) {
                      ToastNotification().showToast(message: state.message, color: redColor);
                    }
                    return WidgetLoadingIndicator(color: primaryColor);
                  },
                ),
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
            child: BlocBuilder<LecturerBloc, LecturerState>(
              builder: (context, state) {
                if (state is DeleteLecturerSuccess) {
                  ToastNotification().showToast(message: state.message, color: greenColor);
                }
                if (state is DeleteLecturerFailed) {
                  ToastNotification().showToast(message: state.message, color: redColor);
                }
                return Text('');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _tableListLecturer(List<Lecturer> listStudent) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: <DataColumn>[DataColumn(label: Text('Email')), DataColumn(label: Text('Name')), DataColumn(label: Text('History Room')), DataColumn(label: Text('Actions'))],
        rows: listStudent
            .map(
              (e) => DataRow(
                cells: <DataCell>[
                  DataCell(Text(e.lecturerEmail)),
                  DataCell(Text(e.lecturerName)),
                  DataCell(Text(e.historyRoom.length.toString())),
                  DataCell(Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: redColor,
                        ),
                        onPressed: () {
                          _handleDeleteButton(e.lecturerEmail);
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
