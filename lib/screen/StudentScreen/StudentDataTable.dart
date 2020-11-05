import 'dart:convert';

import 'package:attendance_admin/components/Toast.dart';
import 'package:attendance_admin/constant/Constant.dart';
import 'package:attendance_admin/models/StudentModel.dart';
import 'package:attendance_admin/screen/StudentScreen/StudentAddNew.dart';
import 'package:attendance_admin/screen/StudentScreen/StudentDataSource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class StudentDataTable extends StatefulWidget {
  final Function(StudentModel) callback;

  StudentDataTable(this.callback);

  @override
  _StudentDataTableState createState() => _StudentDataTableState();
}

class _StudentDataTableState extends State<StudentDataTable> {
  bool sort;
  int sortColumnIndex;
  List<StudentModel> dataTable;
  Function onRowSelect;
  ToastComponents toastComponents;
  FToast fToast;

  @override
  void initState() {
    super.initState();
    sort = true;
    fetchingDataTable('');
    fToast = FToast();
    fToast.init(context);
    toastComponents = ToastComponents(fToast: fToast);
  }

  fetchingDataTable(String studentId) async {
    try {
      List<StudentModel> listStudent;
      var body;
      var params = '/student/list';
      if (studentId != '') {
        params = '/student/list?student_id=' + studentId;
      }
      var response = await http.post(apiURL + params);

      if (response.statusCode == 200) {
        body = await json.decode(response.body);
        if (body['data'] != null) {
          var respData = body['data'] as List;
          listStudent = respData
              .map<StudentModel>(
                (json) => StudentModel.fromJson(json),
              )
              .toList();
          setState(() {
            dataTable = listStudent;
          });
        }
      } else {
        setState(() {
          dataTable = null;
        });
        print(response.body);
      }
    } catch (e) {
      print(e.toString());
      await toastComponents.showToast(
        '400',
        'Not connected to servers',
      );
    }
  }

  handleSortColumn(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        dataTable.sort((a, b) => a.student_id.compareTo(b.student_id));
      } else {
        dataTable.sort((a, b) => b.student_id.compareTo(a.student_id));
      }
    } else if (columnIndex == 1) {
      if (ascending) {
        dataTable.sort((a, b) => a.student_name.compareTo(b.student_name));
      } else {
        dataTable.sort((a, b) => b.student_name.compareTo(a.student_name));
      }
    }
  }

  setDetails(StudentModel studentModel) {
    widget.callback(studentModel);
  }

  handleAddNewStudent(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: StudentAddNew(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final spinkit = SpinKitWave(
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: primaryColor,
          ),
        );
      },
    );

    final source = StudentDataSource(
      onRowSelect: (index) => setDetails(dataTable[index]),
      studentList: dataTable,
    );

    if (dataTable == null) {
      return spinkit;
    } else {
      return PaginatedDataTable(
        showCheckboxColumn: false,
        header: Center(
          child: Text(
            'List Student',
            style: TextStyle(
              color: primaryColor,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        sortColumnIndex: sortColumnIndex,
        sortAscending: sort,
        columns: <DataColumn>[
          DataColumn(
            tooltip: 'Student ID',
            numeric: true,
            label: Text('Student ID'),
            onSort: (columnIndex, ascending) {
              setState(() {
                sortColumnIndex = columnIndex;
                sort = sort == sort ? !sort : sort;
              });
              handleSortColumn(columnIndex, ascending);
            },
          ),
          DataColumn(
            tooltip: 'Student Name',
            label: Text('Student Name'),
            onSort: (columnIndex, ascending) {
              setState(() {
                sortColumnIndex = columnIndex;
                sort = sort == sort ? !sort : sort;
              });
              handleSortColumn(columnIndex, ascending);
            },
          ),
          DataColumn(
            tooltip: 'Batch',
            label: Text('Batch'),
            numeric: true,
          ),
          DataColumn(
            tooltip: 'Major',
            label: Text('Major'),
          ),
        ],
        source: source,
        actions: [
          Container(
            child: IconButton(
              iconSize: 30.0,
              icon: Icon(
                Icons.add_outlined,
                color: greenColor,
              ),
              onPressed: () {
                handleAddNewStudent(context);
              },
            ),
          ),
          Container(
            child: IconButton(
              iconSize: 30.0,
              icon: Icon(
                Icons.refresh_rounded,
                color: greyColor,
              ),
              onPressed: () {
                fetchingDataTable('');
              },
            ),
          ),
        ],
      );
    }
  }
}
