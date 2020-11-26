import 'package:attendance_admin/ui/view/RoomView/components/room_detail_controller.dart';
import 'package:flutter/material.dart';

class RoomView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 100,
      child: RoomDetailController(),
    );
  }
}
