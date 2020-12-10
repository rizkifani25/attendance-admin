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

  @override
  String toString() => 'Admin(email: $email, password: $password)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Admin && o.email == email && o.password == password;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode;
}
