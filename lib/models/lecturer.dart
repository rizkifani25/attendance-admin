class Lecturer {
  String lecturerEmail;
  String lecturerName;
  String password;
  List historyRoom;

  Lecturer({
    this.lecturerEmail,
    this.lecturerName,
    this.password,
    this.historyRoom,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["lecturer_email"] = this.lecturerEmail;
    data["lecturer_name"] = this.lecturerName;
    data["password"] = this.password;
    data["history_room"] = this.historyRoom;
    return data;
  }

  factory Lecturer.fromJson(Map<String, dynamic> json) {
    return Lecturer(
        lecturerEmail: json['lecturer_email'],
        lecturerName: json['lecturer_name'],
        password: json['password'],
        historyRoom: json['history_room']);
  }
}
