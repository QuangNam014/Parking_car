class CustomerInforModel {
  final String userDocument;
  final String userLicense;

  CustomerInforModel({required this.userDocument, required this.userLicense});

  Map<String, dynamic> toJson() {
    return {
      'userDocument': userDocument,
      'userLicense': userLicense,
    };
  }

  factory CustomerInforModel.fromJson(Map<String, dynamic> data) {
    return CustomerInforModel(
      userDocument: data['userDocument'] ?? "",
      userLicense: data['userLicense'] ?? "",
    );
  }
}