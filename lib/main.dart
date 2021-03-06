import 'package:attendance_admin/constant/Constant.dart';
import 'package:attendance_admin/data/dataproviders/dataproviders.dart';
import 'package:attendance_admin/data/repositories/repositories.dart';
import 'package:attendance_admin/ui/logic/bloc/bloc.dart';
import 'package:attendance_admin/ui/view/Widgets/widgets.dart';
import 'package:attendance_admin/ui/view/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AdminRepository>(create: (context) => AdminRepository(attendanceApi: AttendanceApi())),
        RepositoryProvider<AttendanceRepository>(create: (context) => AttendanceRepository(attendanceApi: AttendanceApi())),
        RepositoryProvider<LecturerRepository>(create: (context) => LecturerRepository(attendanceApi: AttendanceApi())),
        RepositoryProvider<StudentRepository>(create: (context) => StudentRepository(attendanceApi: AttendanceApi()))
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc()..add(AppLoaded()),
          ),
          BlocProvider<PageBloc>(
            create: (context) => PageBloc()..add(RenderSelectedPage(pageState: 0)),
          ),
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(
              adminRepository: AdminRepository(attendanceApi: AttendanceApi()),
              authBloc: BlocProvider.of<AuthBloc>(context),
            ),
          ),
          BlocProvider<DashboardBloc>(
            create: (context) => DashboardBloc(
              attendanceRepository: AttendanceRepository(attendanceApi: AttendanceApi()),
            )..add(
                GetDashboardData(),
              ),
          ),
          BlocProvider<LecturerBloc>(
            create: (context) => LecturerBloc(
              lecturerRepository: LecturerRepository(attendanceApi: AttendanceApi()),
            ),
          ),
          BlocProvider<StudentBloc>(
            create: (context) => StudentBloc(
              studentRepository: StudentRepository(attendanceApi: AttendanceApi()),
              attendanceRepository: AttendanceRepository(attendanceApi: AttendanceApi()),
            ),
          )
        ],
        child: AdminAttendanceApp(),
      ),
    ),
  );
}

class AdminAttendanceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Attendance App',
      theme: ThemeData(
        fontFamily: 'Raleway',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthAuthenticated) {
            return DashboardView();
          }

          if (state is AuthNotAuthenticated) {
            return LoginView();
            // return DashboardView();
          }

          if (state is AuthFailure) {
            ToastNotification().showToast(message: state.message, color: redColor);
          }

          return WidgetLoadingIndicator(color: primaryColor);
        },
      ),
    );
  }
}
