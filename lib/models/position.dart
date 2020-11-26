class PositionStudent {
  final double latitude;
  final double longitude;

  PositionStudent({this.latitude, this.longitude});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }

  factory PositionStudent.fromJson(Map<String, dynamic> json) {
    return PositionStudent(
      latitude: json['latitude'] ?? 0.0,
      longitude: json['longitude'] ?? 0.0,
    );
  }
}
