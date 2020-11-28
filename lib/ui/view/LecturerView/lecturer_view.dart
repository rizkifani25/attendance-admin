import 'package:attendance_admin/ui/view/LecturerView/components/lecturer_view_components.dart';
import 'package:flutter/material.dart';

class LecturerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 100,
      child: ListLecturerView(),
    );
  }
}
