import 'package:attendance_admin/models/models.dart';

class ListTime {
  Time time1;
  Time time2;
  Time time3;
  Time time4;

  ListTime({this.time1, this.time2, this.time3, this.time4});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['time1'] = this.time1;
    data['time2'] = this.time2;
    data['time3'] = this.time3;
    data['time4'] = this.time4;
    return data;
  }

  factory ListTime.fromJson(Map<String, dynamic> json) {
    return ListTime(
      time1: Time.fromJson(json['time1']),
      time2: Time.fromJson(json['time2']),
      time3: Time.fromJson(json['time3']),
      time4: Time.fromJson(json['time4']),
    );
  }

  @override
  String toString() {
    return 'ListTime(time1: $time1, time2: $time2, time3: $time3, time4: $time4)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ListTime && o.time1 == time1 && o.time2 == time2 && o.time3 == time3 && o.time4 == time4;
  }

  @override
  int get hashCode {
    return time1.hashCode ^ time2.hashCode ^ time3.hashCode ^ time4.hashCode;
  }
}
