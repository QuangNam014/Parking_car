class ChangedPasswordRequest {
  final String password;
  final String confirmPassword;

  ChangedPasswordRequest({required this.password, required this.confirmPassword});

  Map<String, dynamic> toJson() {
    return {
      'password': password,
      'confirmPassword': confirmPassword,
    };
  }

  factory ChangedPasswordRequest.fromJson(Map<String, dynamic> data) {
    return ChangedPasswordRequest(
      password: data['password'] ?? "",
      confirmPassword: data['confirmPassword'] ?? "",
    );
  }
}