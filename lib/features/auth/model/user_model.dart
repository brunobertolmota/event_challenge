class UserModel {
  String email;
  String password;

  UserModel({
    required this.email,
    required this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json['email'],
        password: json['password'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> user = {};
    user['email'] = email;
    user['password'] = password;

    return user;
  }
}
