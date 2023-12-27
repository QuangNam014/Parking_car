class RegisterModel {
  final String fullname;
  final String email;
  final String password;
  final String phone;

  RegisterModel({required this.fullname, required this.email, required this.password, required this.phone});

  Map<String, dynamic> toJson() {
    return {
      'fullname': fullname,
      'email': email,
      'password': password,
      'phone': phone,
    };
  }

  factory RegisterModel.fromJson(Map<String, dynamic> data) {
    return RegisterModel(
      fullname: data['fullname'] ?? "",
      email: data['email'] ?? "",
      password: data['password'] ?? "",
      phone: data['phone'] ?? "",
    );
  }
}