class Admin {
  String email;
  String password;

  Admin({this.email, this.password});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['email'] = email;
    data['password'] = this.password;
    return data;
  }

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      email: json['email'],
      password: json['password'],
    );
  }
}
