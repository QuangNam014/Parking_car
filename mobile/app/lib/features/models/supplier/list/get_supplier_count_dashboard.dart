
class GetDataSupplierCountModel {
  final int totalSuccess;
  final int totalCancel;
  final int totalAllSlot;
  final int totalTransaction;

  GetDataSupplierCountModel({required this.totalSuccess, required this.totalCancel, required this.totalAllSlot, required this.totalTransaction});


  factory GetDataSupplierCountModel.fromJson(Map<String, dynamic> json) {
    return GetDataSupplierCountModel(
      totalSuccess: json['totalSuccess'] ?? 0,
      totalCancel: json['totalCancel'] ?? 0,
      totalAllSlot: json['totalAllSlot'] ?? 0,
      totalTransaction: json['totalTransaction'] ?? 0,
    );
  }

}