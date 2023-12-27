class ChangedPasswordModel {
  final String email;
  final String password;
  final String confirmPassword;

  ChangedPasswordModel({required this.email, required this.password, required this.confirmPassword});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
    };
  }

  factory ChangedPasswordModel.fromJson(Map<String, dynamic> data) {
    return ChangedPasswordModel(
      email: data['email'] ?? "",
      password: data['password'] ?? "",
      confirmPassword: data['confirmPassword'] ?? "",
    );
  }
}