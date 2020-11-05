class StudentModel {
  String student_id;
  String student_name;
  String password;
  String batch;
  String major;
  Object additional_data;

  StudentModel({
    this.student_id,
    this.student_name,
    this.password,
    this.batch,
    this.major,
    this.additional_data,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["student_id"] = this.student_id;
    data["student_name"] = this.student_name;
    data["password"] = this.password;
    data["batch"] = this.batch;
    data["major"] = this.major;
    data["additional_data"] = this.additional_data;
    return data;
  }

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
        student_id: json['student_id'],
        student_name: json['student_name'],
        password: json['password'],
        batch: json['batch'],
        major: json['major'],
        additional_data: json['additional_data']);
  }
}
