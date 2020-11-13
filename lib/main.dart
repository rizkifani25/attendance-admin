import 'package:attendance_admin/data/dataproviders/attendanceAPI.dart';
import 'package:attendance_admin/data/repositories/attendanceRepository.dart';
import 'package:attendance_admin/ui/logic/bloc/auth/auth_bloc.dart';
import 'package:attendance_admin/ui/logic/bloc/dashboard/dashboard_bloc.dart';
import 'package:attendance_admin/ui/logic/bloc/login/login_bloc.dart';
import 'package:attendance_admin/ui/logic/bloc/student/student_bloc.dart';
import 'package:attendance_admin/ui/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

void main() {
  final attendanceRepository = AttendanceRepository(
    attendanceApi: AttendanceApi(
      httpClient: http.Client(),
    ),
  );
  runApp(
    RepositoryProvider.value(
      value: attendanceRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              attendanceRepository: attendanceRepository,
            )..add(
                AppLoaded(),
              ),
          ),
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(
              attendanceRepository: attendanceRepository,
              authBloc: BlocProvider.of<AuthBloc>(context),
            ),
          ),
          BlocProvider<DashboardBloc>(
            create: (context) => DashboardBloc(attendanceRepository: attendanceRepository)
              ..add(
                GetDashboardData(),
              ),
          ),
          BlocProvider<StudentBloc>(
            create: (context) => StudentBloc(attendanceRepository: attendanceRepository)
              ..add(
                GetStudentAddNewPageData(),
              ),
          )
        ],
        child: AdminAttendanceApp(
          appRouter: AppRouter(),
        ),
      ),
    ),
  );
}

class AdminAttendanceApp extends StatelessWidget {
  final AppRouter appRouter;

  const AdminAttendanceApp({Key key, @required this.appRouter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Attendance App',
      theme: ThemeData(
        fontFamily: 'Raleway',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateRoute: appRouter.onGenerateRoute,
    );
  }
}
