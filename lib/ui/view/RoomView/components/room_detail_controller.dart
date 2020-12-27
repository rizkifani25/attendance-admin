import 'package:attendance_admin/constant/Constant.dart';
import 'package:attendance_admin/models/models.dart';
import 'package:attendance_admin/models/room_detail.dart';
import 'package:attendance_admin/ui/components/components.dart';
import 'package:attendance_admin/ui/logic/bloc/dashboard/dashboard_bloc.dart';
import 'package:attendance_admin/ui/view/RoomView/components/room_detail.dart';
import 'package:attendance_admin/ui/view/Widgets/widgets.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'room_register_controller.dart';

class RoomDetailController extends StatefulWidget {
  @override
  _RoomDetailControllerState createState() => _RoomDetailControllerState();
}

class _RoomDetailControllerState extends State<RoomDetailController> {
  int _selectedRoom;
  String _dateNow;
  List<Room> _listRooms;

  @override
  void initState() {
    _selectedRoom = 1;
    _dateNow = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
    BlocProvider.of<DashboardBloc>(context).add(
      GetDashboardData(
        roomName: 'B101',
        date: _dateNow,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _handleSendDateAndRoomName() {
    BlocProvider.of<DashboardBloc>(context).add(
      GetDashboardData(
        roomName: _listRooms[_selectedRoom - 1].room,
        date: _dateNow,
      ),
    );
  }

  _handleDateChange(date) {
    setState(() {
      _dateNow = date.toString();
    });
  }

  _handleCalendarButton(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialogBox(
          children: [
            Center(
                child: Calendar(
              onSelectedDate: (date) => _handleDateChange(date),
            )),
          ],
        );
      },
    ).then((value) => _handleSendDateAndRoomName());
  }

  _handleEnrolledDetailButton(BuildContext context, String time, String subject, List<Enrolled> enrolled, Lecturer lecturer, RoomStatus status) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialogBox(
          children: [
            Center(
              child: RoomRegister(time: time, subject: subject, enrolled: enrolled, lecturer: lecturer, status: status, roomName: _listRooms[_selectedRoom - 1].room, date: _dateNow),
            ),
          ],
        );
      },
    ).then((value) => _handleSendDateAndRoomName());
  }

  _handleDetailsButton(BuildContext context, String time, RoomDetail data) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialogBox(
          children: [
            Center(
              child: RoomDetails(time: time, roomDetail: data),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(20),
        child: Stack(
          children: [
            BlocBuilder<DashboardBloc, DashboardState>(
              builder: (context, state) {
                if (state is DashboardLoadData) {
                  _listRooms = state.listRoomTime;
                  return Row(
                    children: [
                      Container(
                        width: 350,
                        child: Card(
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Select Room : ',
                                  style: TextStyle(
                                    color: greyColor,
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                              DropdownButton(
                                hint: Text('Select Room'),
                                value: _selectedRoom,
                                items: state.listRoomTime.map((e) {
                                  return DropdownMenuItem(
                                    child: Text(e.room),
                                    value: e.id,
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedRoom = value;
                                  });
                                  _handleSendDateAndRoomName();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 350,
                        child: Card(
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Select Date : ',
                                  style: TextStyle(
                                    color: greyColor,
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                              FlatButton(
                                child: Padding(
                                  padding: EdgeInsets.all(7),
                                  child: Text(
                                    _dateNow,
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 24,
                                    ),
                                  ),
                                ),
                                focusColor: hoverColor,
                                color: transparentColor,
                                onPressed: () => _handleCalendarButton(context),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: IconButton(
                          icon: Icon(
                            Icons.refresh_rounded,
                            size: 25,
                            color: primaryColor,
                          ),
                          onPressed: () => _handleSendDateAndRoomName(),
                        ),
                      )
                    ],
                  );
                }
                return Container();
              },
            ),
            Container(
              alignment: Alignment.center,
              child: BlocBuilder<DashboardBloc, DashboardState>(
                builder: (context, state) {
                  if (state is DashboardLoadData) {
                    return Container(
                      child: _tableRoomDetail(state.detailRoom, state.listTime),
                    );
                  }
                  return WidgetLoadingIndicator(color: primaryColor);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tableRoomDetail(RoomDetail data, List<String> time) {
    final List fixedList = Iterable<int>.generate(time.length).toList();
    final tableHeadStyle = TextStyle(
      color: greyColor2,
      fontSize: 12,
      fontWeight: FontWeight.w500,
    );
    final sizedBox = SizedBox(height: 12);
    final ScrollController scrollController = ScrollController();
    final minWidthColumn = MediaQuery.of(context).size.width / 7;
    List<Time> listTime = [data.listTime.time1, data.listTime.time2, data.listTime.time3, data.listTime.time4];

    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.4,
      child: Scrollbar(
        isAlwaysShown: true,
        controller: scrollController,
        child: ListView.builder(
          physics: BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          scrollDirection: Axis.vertical,
          controller: scrollController,
          itemCount: 1,
          itemBuilder: (context, index) {
            return Column(
                children: fixedList
                    .map(
                      (e) => Container(
                        constraints: BoxConstraints(
                          minWidth: 1000,
                          minHeight: 100,
                          maxHeight: 150,
                        ),
                        child: Card(
                          color: secondaryColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                constraints: BoxConstraints(minWidth: minWidthColumn),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'Time',
                                      style: tableHeadStyle,
                                    ),
                                    Text(
                                      time[e],
                                    ),
                                    sizedBox,
                                  ],
                                ),
                              ),
                              Container(
                                constraints: BoxConstraints(minWidth: minWidthColumn),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'Subject',
                                      style: tableHeadStyle,
                                    ),
                                    Text(
                                      listTime[e].subject != '' ? listTime[e].subject : 'EMPTY SUBJECT',
                                    ),
                                    sizedBox,
                                  ],
                                ),
                              ),
                              Container(
                                constraints: BoxConstraints(minWidth: minWidthColumn),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'Students',
                                      style: tableHeadStyle,
                                    ),
                                    MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        onTap: () {
                                          _handleEnrolledDetailButton(
                                            context,
                                            time[e],
                                            listTime[e].subject != '' ? listTime[e].subject : '',
                                            listTime[e].enrolled.isEmpty ? [] : listTime[e].enrolled,
                                            listTime[e].lecturer,
                                            listTime[e].status,
                                          );
                                        },
                                        child: Container(
                                          child: listTime[e].enrolled.isNotEmpty ? _studentEnrolled(listTime[e].enrolled) : Text('NO STUDENT ENROLLED'),
                                        ),
                                      ),
                                    ),
                                    sizedBox,
                                  ],
                                ),
                              ),
                              Container(
                                constraints: BoxConstraints(minWidth: minWidthColumn),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'Lecturer',
                                      style: tableHeadStyle,
                                    ),
                                    Text(
                                      listTime[e].lecturer.lecturerName != '' ? listTime[e].lecturer.lecturerName : 'TBA',
                                    ),
                                    sizedBox,
                                  ],
                                ),
                              ),
                              Container(
                                constraints: BoxConstraints(minWidth: minWidthColumn),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'Status',
                                      style: tableHeadStyle,
                                    ),
                                    _statusBadge(listTime[e].status),
                                    sizedBox,
                                  ],
                                ),
                              ),
                              Container(
                                constraints: BoxConstraints(minWidth: minWidthColumn),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'Details',
                                      style: tableHeadStyle,
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.info_outline_rounded),
                                      onPressed: () {
                                        _handleDetailsButton(
                                          context,
                                          time[e],
                                          data,
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList());
          },
        ),
      ),
    );
  }

  Widget _statusBadge(RoomStatus roomStatus) {
    return Badge(
      animationDuration: Duration(milliseconds: 300),
      animationType: BadgeAnimationType.scale,
      shape: BadgeShape.square,
      badgeColor: roomStatus.status ? redColor : greenColor,
      borderRadius: BorderRadius.circular(8),
      badgeContent: Text(
        roomStatus.statusMessage ?? 'Available',
        style: TextStyle(color: secondaryColor),
      ),
    );
  }

  Widget _studentEnrolled(List<Enrolled> data) {
    final List fixedList = Iterable<int>.generate(data.length).toList();

    return Stack(
      fit: StackFit.passthrough,
      children: fixedList.length > 3
          ? fixedList
              .map(
                (e) => e < 4
                    ? _profilePictureStudent(
                        margin: (e * 20).toString(),
                        remainder: e == 3 ? (fixedList.length - 3).toString() : '',
                      )
                    : Container(),
              )
              .toList()
          : fixedList
              .map(
                (e) => _profilePictureStudent(
                  margin: (e * 20).toString(),
                  remainder: '',
                ),
              )
              .toList(),
    );
  }

  Widget _profilePictureStudent({String remainder, String margin}) {
    return Container(
      margin: EdgeInsets.only(left: double.parse(margin)),
      width: 35,
      height: 35,
      decoration: remainder != ''
          ? BoxDecoration()
          : BoxDecoration(
              border: Border.all(
                color: secondaryColor,
                width: 2,
                style: BorderStyle.solid,
              ),
              shape: BoxShape.circle,
              image: new DecorationImage(
                fit: BoxFit.fill,
                image: new NetworkImage("https://i.imgur.com/BoN9kdC.png"),
              ),
            ),
      child: remainder != ''
          ? Container(
              width: 35,
              height: 35,
              child: Center(
                child: Text(
                  '+' + remainder,
                  style: TextStyle(
                    fontSize: 16,
                    color: textColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: blueColor,
                border: Border.all(
                  color: secondaryColor,
                  width: 2,
                  style: BorderStyle.solid,
                ),
                shape: BoxShape.circle,
              ),
            )
          : Container(),
    );
  }
}
