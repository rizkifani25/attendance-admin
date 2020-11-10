import 'package:attendance_admin/ui/view/view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => DashboardView());
      default:
        return MaterialPageRoute(
          builder: (_) => Center(
            child: Scaffold(
              body: Center(
                child: Container(
                  child: Text(
                    '404 Not found',
                    style: TextStyle(fontSize: 28),
                  ),
                ),
              ),
            ),
          ),
        );
    }
  }
}
