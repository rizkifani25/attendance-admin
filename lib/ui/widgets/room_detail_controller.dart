import 'package:attendance_admin/constant/Constant.dart';
import 'package:attendance_admin/models/models.dart';
import 'package:attendance_admin/models/room_detail_response.dart';
import 'package:attendance_admin/ui/logic/bloc/dashboard/dashboard_bloc.dart';
import 'package:attendance_admin/ui/widgets/calendar.dart';
import 'package:attendance_admin/ui/widgets/room_register_controller.dart';
import 'package:attendance_admin/ui/widgets/student_add_new_panel.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    super.initState();
    _selectedRoom = 1;
    _dateNow = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
    BlocProvider.of<DashboardBloc>(context).add(
      GetDashboardData(
        roomName: 'B101',
        date: _dateNow,
      ),
    );
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
    showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      enableDrag: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height / 1.3,
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Container(
            child: Stack(
              children: [
                Calendar(
                  onSelectedDate: (date) => _handleDateChange(date),
                ),
              ],
            ),
          ),
        );
      },
    ).whenComplete(() => _handleSendDateAndRoomName());
  }

  _handleEnrolledDetailButton(
    BuildContext context,
    String time,
    String subject,
    List<Enrolled> enrolled,
    String lecturer,
    bool status,
  ) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      enableDrag: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height / 1.2,
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Container(
            child: RoomRegister(
              time: time,
              subject: subject,
              enrolled: enrolled,
              lecturer: lecturer,
              status: status,
              roomName: _listRooms[_selectedRoom - 1].room,
              date: _dateNow,
            ),
          ),
        );
      },
    ).whenComplete(() => _handleSendDateAndRoomName());
  }

  _handleShowPanelAddNewStudentButton(BuildContext context) {
    showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      enableDrag: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height / 1.2,
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: StudentAddNew(),
        );
      },
    ).whenComplete(() => _handleSendDateAndRoomName());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state is DashboardLoadData) {
            _listRooms = state.listRoomTime;
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                      SizedBox(
                        width: 50,
                      ),
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
                      SizedBox(
                        width: 50,
                      ),
                      FlatButton(
                        child: Padding(
                          padding: EdgeInsets.all(7),
                          child: Text(
                            'Add New Student',
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        focusColor: hoverColor,
                        color: transparentColor,
                        onPressed: () => _handleShowPanelAddNewStudentButton(context),
                      ),
                    ],
                  ),
                  Container(
                    child: _tableRoomDetail(state.detailRoom, state.listTime),
                  ),
                ],
              ),
            );
          }
          if (state is DashboardLoadDataFailure) {
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
          if (state is DashboardLoadDataSuccess) {
            Fluttertoast.showToast(
              webBgColor: "linear-gradient(to right, #2e7d32, #388e3c)",
              msg: state.message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: greenColor,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
          return Center(
            child: Container(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _tableRoomDetail(RoomDetailResponse data, List<String> time) {
    final List fixedList = Iterable<int>.generate(time.length).toList();
    final tableHeadStyle = TextStyle(
      color: greyColor2,
      fontSize: 12,
      fontWeight: FontWeight.w500,
    );
    final sizedBox = SizedBox(height: 12);
    final ScrollController scrollController = ScrollController();
    final minWidthColumn = MediaQuery.of(context).size.width / 5.5;
    List<Time> listTime = [
      data.listTime.time1,
      data.listTime.time2,
      data.listTime.time3,
      data.listTime.time4
    ];

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
                                      listTime[e].subject != ''
                                          ? listTime[e].subject
                                          : 'SUBJECT KOSONG',
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
                                            listTime[e].enrolled.isEmpty
                                                ? []
                                                : listTime[e].enrolled,
                                            listTime[e].lecturer != '' ? listTime[e].lecturer : '',
                                            listTime[e].status ? listTime[e].status : false,
                                          );
                                        },
                                        child: Container(
                                          child: listTime[e].enrolled.isNotEmpty
                                              ? _studentEnrolled(listTime[e].enrolled)
                                              : Text('ENROLLED KOSONG'),
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
                                      listTime[e].lecturer != ''
                                          ? listTime[e].lecturer
                                          : 'LECTURER KOSONG',
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
                                    listTime[e].status
                                        ? _statusBookedBadge()
                                        : _statusAvailableBadge(),
                                    sizedBox,
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

  Widget _statusAvailableBadge() {
    return Badge(
      animationDuration: Duration(milliseconds: 300),
      animationType: BadgeAnimationType.scale,
      shape: BadgeShape.square,
      badgeColor: greenColor,
      borderRadius: BorderRadius.circular(8),
      badgeContent: Text(
        'Available',
        style: TextStyle(color: secondaryColor),
      ),
    );
  }

  Widget _statusBookedBadge() {
    return Badge(
      animationDuration: Duration(milliseconds: 300),
      animationType: BadgeAnimationType.scale,
      shape: BadgeShape.square,
      badgeColor: redColor,
      borderRadius: BorderRadius.circular(8),
      badgeContent: Text(
        'Booked',
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
