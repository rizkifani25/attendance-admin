import 'package:attendance_admin/models/RoomModel.dart';
import 'package:flutter/material.dart';

typedef OnRowSelect = void Function(int index);

class RoomDataSource extends DataTableSource {
  final List<RoomModel> _roomList;
  final OnRowSelect onRowSelect;

  RoomDataSource({@required List<RoomModel> roomList, @required this.onRowSelect})
      : _roomList = roomList == null ? [] : roomList;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);

    if (index >= _roomList.length) {
      return null;
    }

    final _room = _roomList[index];

    return DataRow.byIndex(
      index: index,
      onSelectChanged: (value) {
        onRowSelect(index);
      },
      cells: <DataCell>[
        DataCell(Text('${_room.room}')),
        // DataCell(Text('${_room.room_name}')),
        // DataCell(Text('${_room.batch}')),
        // DataCell(Text('${_room.major}')),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _roomList.length;

  @override
  int get selectedRowCount => 0;
}
