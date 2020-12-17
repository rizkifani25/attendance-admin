import 'package:attendance_admin/constant/Constant.dart';
import 'package:attendance_admin/ui/logic/bloc/bloc.dart';
import 'package:attendance_admin/ui/view/Widgets/widgets.dart';
import 'package:attendance_admin/ui/view/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthNotAuthenticated) {
                  // return LoginView();
                  return _DashboardContent();
                }

                if (state is AuthAuthenticated) {
                  return _DashboardContent();
                }

                return WidgetLoadingIndicator(color: primaryColor);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _DashboardContent extends StatefulWidget {
  @override
  __DashboardContentState createState() => __DashboardContentState();
}

class __DashboardContentState extends State<_DashboardContent> {
  int _pageState;

  @override
  void initState() {
    _pageState = 0;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _handleLogOut() {
    BlocProvider.of<AuthBloc>(context).add(UserLoggedOut());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Container(
            width: 100,
            color: primaryColor,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: Image.asset(
                      'icon/calendar.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 60,
                    width: 60,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.calendar_today_outlined,
                            size: 25,
                            color: _pageState == 0 ? secondaryColor : blueColor,
                          ),
                          onPressed: () {
                            setState(() {
                              _pageState = 0;
                            });
                            BlocProvider.of<PageBloc>(context).add(
                              RenderSelectedPage(pageState: 0),
                            );
                          },
                        ),
                        Text(
                          'Schedule',
                          style: TextStyle(
                            fontSize: 12,
                            color: _pageState == 0 ? secondaryColor : blueColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 60,
                    width: 60,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.person_outline_rounded,
                            size: 25,
                            color: _pageState == 1 ? secondaryColor : blueColor,
                          ),
                          onPressed: () {
                            setState(() {
                              _pageState = 1;
                            });
                            BlocProvider.of<PageBloc>(context).add(
                              RenderSelectedPage(pageState: 1),
                            );
                          },
                        ),
                        Text(
                          'Lecturer',
                          style: TextStyle(
                            fontSize: 12,
                            color: _pageState == 1 ? secondaryColor : blueColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 60,
                    width: 60,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.person_pin,
                            size: 25,
                            color: _pageState == 2 ? secondaryColor : blueColor,
                          ),
                          onPressed: () {
                            setState(() {
                              _pageState = 2;
                            });
                            BlocProvider.of<PageBloc>(context).add(
                              RenderSelectedPage(pageState: 2),
                            );
                          },
                        ),
                        Text(
                          'Student',
                          style: TextStyle(
                            fontSize: 12,
                            color: _pageState == 2 ? secondaryColor : blueColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: SizedBox(
                        height: 60,
                        width: 60,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              hoverColor: secondaryColor,
                              tooltip: 'Logout',
                              icon: Icon(
                                Icons.highlight_off,
                                size: 25,
                                color: blueColor,
                              ),
                              onPressed: () {
                                _handleLogOut();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: BlocBuilder<PageBloc, PageState>(
              builder: (context, state) {
                if (state is PageRoomView) {
                  return RoomView();
                }
                if (state is PageStudentView) {
                  return StudentView();
                }
                if (state is PageLecturerView) {
                  return LecturerView();
                }
                return WidgetLoadingIndicator(color: primaryColor);
              },
            ),
          ),
        ],
      ),
    );
  }
}
