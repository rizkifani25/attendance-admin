import 'package:attendance_admin/data/dataproviders/dataproviders.dart';
import 'package:attendance_admin/data/repositories/repositories.dart';
import 'package:attendance_admin/ui/logic/bloc/bloc.dart';
import 'package:attendance_admin/ui/logic/bloc/lecturer/lecturer_bloc.dart';
import 'package:attendance_admin/ui/router/app_router.dart';
import 'package:attendance_admin/ui/view/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AdminRepository>(
            create: (context) => AdminRepository(attendanceApi: AttendanceApi())),
        RepositoryProvider<AttendanceRepository>(
            create: (context) => AttendanceRepository(attendanceApi: AttendanceApi())),
        RepositoryProvider<LecturerRepository>(
            create: (context) => LecturerRepository(attendanceApi: AttendanceApi())),
        RepositoryProvider<StudentRepository>(
            create: (context) => StudentRepository(attendanceApi: AttendanceApi()))
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
        child: AdminAttendanceApp(
          appRouter: AppRouter(),
        ),
      ),
    ),
  );
}

class AdminAttendanceApp extends StatelessWidget {
  final AppRouter appRouter;

  AdminAttendanceApp({Key key, @required this.appRouter}) : super(key: key);

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
          return DashboardView();
          // if (state is AuthAuthenticated) {

          // }

          // if (state is AuthNotAuthenticated) {
          //   return LoginView();
          // }

          // if (state is AuthFailure) {
          //   Fluttertoast.showToast(
          //     webBgColor: "linear-gradient(to right, #c62828, #d32f2f)",
          //     msg: state.message,
          //     toastLength: Toast.LENGTH_SHORT,
          //     gravity: ToastGravity.CENTER,
          //     timeInSecForIosWeb: 1,
          //     backgroundColor: redColor,
          //     textColor: Colors.white,
          //     fontSize: 16.0,
          //   );
          // }

          // return Center(
          //   child: Container(
          //     child: CircularProgressIndicator(
          //       strokeWidth: 2,
          //     ),
          //   ),
          // );
        },
      ),
    );
  }
}
