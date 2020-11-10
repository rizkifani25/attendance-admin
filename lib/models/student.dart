class Student {
  String studentId;
  String studentName;
  String password;
  String batch;
  String major;
  Object additionalData;

  Student({
    this.studentId,
    this.studentName,
    this.password,
    this.batch,
    this.major,
    this.additionalData,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["student_id"] = this.studentId;
    data["student_name"] = this.studentName;
    data["password"] = this.password;
    data["batch"] = this.batch;
    data["major"] = this.major;
    data["additional_data"] = this.additionalData;
    return data;
  }

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
        studentId: json['student_id'],
        studentName: json['student_name'],
        password: json['password'],
        batch: json['batch'],
        major: json['major'],
        additionalData: json['additional_data']);
  }
}
