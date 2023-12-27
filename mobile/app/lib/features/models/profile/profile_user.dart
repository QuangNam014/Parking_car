class ProfileUser {
  String? fullname;
  String? email;
  String? phone;
  double? wallet;
  String? createdAt;
  String? imageName;
  String? imageUrl;
  String? userDocument;
  String? userLicense;
  String? paymentInfo;

  ProfileUser({
    this.fullname,
    this.email,
    this.phone,
    this.wallet,
    this.createdAt,
    this.imageName,
    this.imageUrl,
    this.userDocument,
    this.userLicense,
    this.paymentInfo
  });

  factory ProfileUser.fromJson(Map<String, dynamic> json) {
    return ProfileUser(
      fullname: json['fullname'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      wallet: json['wallet'] ?? 0,
      createdAt: json['createdAt'] ?? '',
      imageName: json['imageName'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      userDocument: json['userDocument'] ?? '',
      userLicense: json['userLicense'] ?? '',
      paymentInfo: json['paymentInfo'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullname': fullname,
      'email': email,
      'phone': phone,
      'wallet': wallet,
      'createdAt': createdAt,
      'imageName': imageName,
      'imageUrl': imageUrl,
      'userDocument': userDocument,
      'userLicense': userLicense,
      'paymentInfo': paymentInfo,
    };
  }
}