class ProfileUpdateDocCustomerRequest {
  final String userDocument;
  final String userLicense;

  ProfileUpdateDocCustomerRequest({required this.userDocument, required this.userLicense});


  Map<String, dynamic> toJson() {
    return {
      'userDocument': userDocument,
      'userLicense': userLicense,
    };
  }

  factory ProfileUpdateDocCustomerRequest.fromJson(Map<String, dynamic> data) {
    return ProfileUpdateDocCustomerRequest(
      userDocument: data['userDocument'] ?? "",
      userLicense: data['userLicense'] ?? "",
    );
  }
}