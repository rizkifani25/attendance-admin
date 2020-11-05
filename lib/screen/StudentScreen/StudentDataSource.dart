import 'package:attendance_admin/models/StudentModel.dart';
import 'package:flutter/material.dart';

typedef OnRowSelect = void Function(int index);

class StudentDataSource extends DataTableSource {
  final List<StudentModel> _studentList;
  final OnRowSelect onRowSelect;

  StudentDataSource({@required List<StudentModel> studentList, @required this.onRowSelect})
      : _studentList = studentList == null ? [] : studentList;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);

    if (index >= _studentList.length) {
      return null;
    }

    final _student = _studentList[index];

    return DataRow.byIndex(
      index: index,
      onSelectChanged: (value) {
        onRowSelect(index);
      },
      cells: <DataCell>[
        DataCell(Text('${_student.student_id}')),
        DataCell(Text('${_student.student_name}')),
        DataCell(Text('${_student.batch}')),
        DataCell(Text('${_student.major}')),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _studentList.length;

  @override
  int get selectedRowCount => 0;
}
