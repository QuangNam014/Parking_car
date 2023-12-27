class ProfileUpdateRequest {
  final String fullname;
  final String phone;

  final String imageName;
  final String imageUrl;

  ProfileUpdateRequest({required this.fullname, required this.phone, required this.imageName, required this.imageUrl});

  Map<String, dynamic> toJson() {
    return {
      'fullname': fullname,
      'phone': phone,
      'imageName': imageName,
      'imageUrl': imageUrl,
    };
  }

  factory ProfileUpdateRequest.fromJson(Map<String, dynamic> data) {
    return ProfileUpdateRequest(
      fullname: data['fullname'] ?? "",
      phone: data['phone'] ?? "",
      imageName: data['imageName'] ?? "",
      imageUrl: data['imageUrl'] ?? "",
    );
  }
}