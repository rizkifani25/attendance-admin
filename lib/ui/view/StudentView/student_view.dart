import 'package:flutter/material.dart';

import 'components/student_view_components.dart';

class StudentView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 100,
      child: ListStudentView(),
    );
  }
}
