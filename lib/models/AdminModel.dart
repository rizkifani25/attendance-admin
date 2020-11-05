class AdminModel {
  final String username;
  final String password;

  AdminModel({
    this.username,
    this.password,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['username'] = username;
    data['password'] = this.password;
    return data;
  }

  factory AdminModel.fromJson(Map<String, dynamic> json) {
    return AdminModel(
      username: json['username'],
      password: json['password'],
    );
  }
}
