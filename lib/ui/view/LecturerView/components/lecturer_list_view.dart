import 'package:attendance_admin/constant/Constant.dart';
import 'package:attendance_admin/models/models.dart';
import 'package:attendance_admin/ui/logic/bloc/bloc.dart';
import 'package:attendance_admin/ui/view/LecturerView/components/lecturer_view_components.dart';
import 'package:attendance_admin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
    showModalBottomSheet<dynamic>(
      backgroundColor: transparentColor,
      isScrollControlled: true,
      enableDrag: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: LecturerAddnew(),
        );
      },
    ).whenComplete(() => BlocProvider.of<LecturerBloc>(context).add(GetLecturerList()));
  }

  _handleDeleteButton(String lecturerEmail) {
    BlocProvider.of<LecturerBloc>(context).add(DeleteLecturer(lecturerEmail: lecturerEmail));
    BlocProvider.of<LecturerBloc>(context).add(GetLecturerList());
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
                    BlocProvider.of<LecturerBloc>(context)
                        .add(GetLecturerList(lecturerName: string));
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
                body: BlocBuilder<LecturerBloc, LecturerState>(builder: (context, state) {
                  if (state is LecturerListingSuccess) {
                    return _tableListStudent(state.listLecturer);
                  }
                  if (state is LecturerListingFailed) {
                    Fluttertoast.showToast(
                      webBgColor: "linear-gradient(to right, #c62828, #d32f2f)",
                      msg: state.message,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: redColor,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  );
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
            child: BlocBuilder<LecturerBloc, LecturerState>(
              builder: (context, state) {
                if (state is DeleteLecturerSuccess) {
                  Fluttertoast.showToast(
                    webBgColor: "linear-gradient(to right, #c62828, #d32f2f)",
                    msg: state.message,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: greenColor,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                }
                if (state is DeleteLecturerFailed) {
                  Fluttertoast.showToast(
                    webBgColor: "linear-gradient(to right, #c62828, #d32f2f)",
                    msg: state.message,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: redColor,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                }
                return Text('');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _tableListStudent(List<Lecturer> listStudent) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: <DataColumn>[
          DataColumn(label: Text('Email')),
          DataColumn(label: Text('Name')),
          DataColumn(label: Text('History Room')),
          DataColumn(label: Text('Actions'))
        ],
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
