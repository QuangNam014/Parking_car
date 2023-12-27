class StatusRentModel {
  final int id;
  final String status;
  final double totalPrice;

  StatusRentModel({required this.id, required this.status, required this.totalPrice});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'totalPrice': totalPrice,
    };
  }

  factory StatusRentModel.fromJson(Map<String, dynamic> data) {
    return StatusRentModel(
      id: data['id'] ?? 0,
      status: data['status'] ?? "",
      totalPrice: data['totalPrice'] ?? 0,
    );
  }
}