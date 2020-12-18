import 'package:attendance_admin/constant/Constant.dart';
import 'package:attendance_admin/models/models.dart';
import 'package:flutter/material.dart';

class RoomDetails extends StatelessWidget {
  final String time;
  final RoomDetail roomDetail;

  RoomDetails({this.time, this.roomDetail});

  @override
  Widget build(BuildContext context) {
    Time timeDetail;

    if (time == '07.30 - 09.30') {
      timeDetail = roomDetail.listTime.time1;
    }
    if (time == '10.00 - 12.00') {
      timeDetail = roomDetail.listTime.time2;
    }
    if (time == '12.30 - 14.30') {
      timeDetail = roomDetail.listTime.time3;
    }
    if (time == '15.00 - 17.00') {
      timeDetail = roomDetail.listTime.time4;
    }

    TextStyle textStyleTableHead = TextStyle(fontSize: 26, fontWeight: FontWeight.bold);
    TextStyle textStyleTableCell = TextStyle(fontSize: 20);
    TextStyle textStyleTableCellChild = TextStyle(fontSize: 16);

    return Column(
      children: [
        Center(
          child: Text(
            'Detail Room',
            style: TextStyle(color: primaryColor, fontSize: 30),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Table(
            border: TableBorder.all(color: greyColor3, width: 1, style: BorderStyle.solid),
            children: [
              _tableRowBasic(
                tableHead: Text('Room ID', style: textStyleTableHead),
                tableCell: Text(
                  roomDetail.roomId,
                  textAlign: TextAlign.end,
                  style: textStyleTableCell,
                ),
              ),
              _tableRowBasic(
                tableHead: Text('Room Name', style: textStyleTableHead),
                tableCell: Text(
                  roomDetail.roomName,
                  textAlign: TextAlign.end,
                  style: textStyleTableCell,
                ),
              ),
              _tableRowBasic(
                tableHead: Text('Date', style: textStyleTableHead),
                tableCell: Text(
                  roomDetail.date,
                  textAlign: TextAlign.end,
                  style: textStyleTableCell,
                ),
              ),
              _tableRowBasic(
                tableHead: Text('Time', style: textStyleTableHead),
                tableCell: Text(
                  timeDetail.time,
                  textAlign: TextAlign.end,
                  style: textStyleTableCell,
                ),
              ),
              _tableRowBasic(
                tableHead: Text('Room Status', style: textStyleTableHead),
                tableCell: Text(
                  timeDetail.status.statusMessage,
                  textAlign: TextAlign.end,
                  style: textStyleTableCell,
                ),
              ),
              _tableRowBasic(
                tableHead: Text('Subject', style: textStyleTableHead),
                tableCell: Text(
                  timeDetail.subject,
                  textAlign: TextAlign.end,
                  style: textStyleTableCell,
                ),
              ),
              _tableRowBasic(
                tableHead: Text('Lecturer Name', style: textStyleTableHead),
                tableCell: Text(
                  timeDetail.lecturer.lecturerName,
                  textAlign: TextAlign.end,
                  style: textStyleTableCell,
                ),
              ),
              _tableRowBasic(
                tableHead: Text('Lecturer Email', style: textStyleTableHead),
                tableCell: Text(
                  timeDetail.lecturer.lecturerEmail,
                  textAlign: TextAlign.end,
                  style: textStyleTableCell,
                ),
              ),
              _tableRowBasic(
                tableHead: Text('Enrolled', style: textStyleTableHead),
                tableCell: Table(
                  border: TableBorder.all(color: greyColor3, width: 1, style: BorderStyle.solid),
                  children: timeDetail.enrolled.map((e) {
                    return _tableRowBasic(
                      tableHead: Text(
                        e.student.studentId,
                        style: textStyleTableCellChild,
                      ),
                      tableCell: Text(
                        e.student.studentName,
                        textAlign: TextAlign.end,
                        style: textStyleTableCellChild,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  TableRow _tableRowBasic({Widget tableHead, Widget tableCell}) {
    return TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: tableHead,
          ),
        ),
        TableCell(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: tableCell,
          ),
        ),
      ],
    );
  }
}
