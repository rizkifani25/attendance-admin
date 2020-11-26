import 'dart:async';

import 'package:flutter/cupertino.dart';

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      // when user is continuously typing, this cancels the timer
      _timer.cancel();
    }

    // when it will start a new timer looking for the user to stop
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
