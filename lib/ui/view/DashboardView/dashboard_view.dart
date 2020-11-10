import 'package:attendance_admin/constant/Constant.dart';
import 'package:attendance_admin/ui/logic/bloc/auth/auth_bloc.dart';
import 'package:attendance_admin/ui/view/LoginView/login_view.dart';
import 'package:attendance_admin/ui/widgets/room_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardView extends StatefulWidget {
  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  void initState() {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance App'),
        backgroundColor: primaryColor,
        actions: [
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthAuthenticated) {
                return IconButton(
                  icon: Icon(
                    Icons.exit_to_app_rounded,
                    color: secondaryColor,
                  ),
                  tooltip: 'Log Out',
                  onPressed: () => _handleLogOut(),
                );
              }
              return SizedBox(
                width: 30,
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthNotAuthenticated) {
              return LoginView();
            }
            if (state is AuthAuthenticated) {
              return Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    child: RoomDetailController(),
                  ),
                ],
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
      ),
    );
  }
}
