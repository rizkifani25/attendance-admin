import 'package:attendance_admin/constant/Constant.dart';
import 'package:attendance_admin/models/RoomModel.dart';
import 'package:attendance_admin/screen/RoomScreen/RoomDataSource.dart';
import 'package:attendance_admin/screen/StudentScreen/StudentDataSource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RoomDataTable extends StatefulWidget {
  @override
  _RoomDataTableState createState() => _RoomDataTableState();
}

class _RoomDataTableState extends State<RoomDataTable> {
  List<RoomModel> roomList;
  int sortColumnIndex;
  bool sort;

  @override
  void initState() {
    super.initState();
    sort = true;
    fetchingDataTable('');
  }

  fetchingDataTable(String studentId) async {
    setState(() {
      roomList = RoomModel.getRoom();
    });
  }

  setDetails(RoomModel roomModel) {
    print(roomModel.room);
    // widget.callback(studentModel);
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

    final source = RoomDataSource(
      onRowSelect: (index) => setDetails(roomList[index]),
      roomList: roomList,
    );

    if (roomList == null) {
      return spinkit;
    } else {
      return PaginatedDataTable(
        showCheckboxColumn: false,
        header: Center(
          child: Text(
            'List Room',
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
            tooltip: 'Room',
            numeric: true,
            label: Text('Room'),
            onSort: (columnIndex, ascending) {
              setState(() {
                sortColumnIndex = columnIndex;
                sort = sort == sort ? !sort : sort;
              });
              // handleSortColumn(columnIndex, ascending);
            },
          ),
          // DataColumn(
          //   tooltip: 'Student Name',
          //   label: Text('Student Name'),
          //   onSort: (columnIndex, ascending) {
          //     setState(() {
          //       sortColumnIndex = columnIndex;
          //       sort = sort == sort ? !sort : sort;
          //     });
          //     // handleSortColumn(columnIndex, ascending);
          //   },
          // ),
          // DataColumn(
          //   tooltip: 'Batch',
          //   label: Text('Batch'),
          //   numeric: true,
          // ),
          // DataColumn(
          //   tooltip: 'Major',
          //   label: Text('Major'),
          // ),
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
                // handleAddNewStudent(context);
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
