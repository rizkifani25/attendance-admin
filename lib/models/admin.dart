class Admin {
  final String username;
  final String password;

  Admin({
    this.username,
    this.password,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['username'] = username;
    data['password'] = this.password;
    return data;
  }

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      username: json['username'],
      password: json['password'],
    );
  }

  @override
  String toString() => 'Admin { username: $username, password: $password }';
}
