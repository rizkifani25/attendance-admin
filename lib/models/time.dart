class Time {
  final bool status;
  final List enrolled;
  final String lecturer;
  final String subject;

  Time({
    this.status,
    this.enrolled,
    this.lecturer,
    this.subject,
  });

  static List<String> getRoomTime() {
    return [
      '07.30 - 09.30',
      '10.00 - 12.00',
      '12.30 - 14.30',
      '15.00 - 17.00',
    ];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['enrolled'] = this.enrolled;
    data['lecturer'] = this.lecturer;
    data['subject'] = this.subject;
    return data;
  }

  factory Time.fromJson(Map<String, dynamic> json) {
    return Time(
      status: json['status'],
      enrolled: json['enrolled'],
      lecturer: json['lecturer'],
      subject: json['subject'],
    );
  }
}
