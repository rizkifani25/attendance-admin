class StatusAttendance {
  String byDistance;
  String byTime;
  String byPhoto;

  StatusAttendance({this.byDistance, this.byTime, this.byPhoto});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['by_distance'] = this.byDistance ?? '-';
    data['by_time'] = this.byTime ?? '-';
    data['by_photo'] = this.byPhoto ?? '-';
    return data;
  }

  factory StatusAttendance.fromJson(Map<String, dynamic> json) {
    return StatusAttendance(
      byDistance: json['by_distance'] ?? '-',
      byTime: json['by_time'] ?? '-',
      byPhoto: json['by_photo'] ?? '-',
    );
  }

  @override
  String toString() => 'StatusAttendance(byDistance: $byDistance, byTime: $byTime, byPhoto: $byPhoto)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is StatusAttendance && o.byDistance == byDistance && o.byTime == byTime && o.byPhoto == byPhoto;
  }

  @override
  int get hashCode => byDistance.hashCode ^ byTime.hashCode ^ byPhoto.hashCode;
}
