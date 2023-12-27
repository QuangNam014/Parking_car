class ProductOrderParkModel {
  final int id;
  final int totalTime;
  final double totalPrice;
  final String parkingTimeStart;
  final String parkingTimeEnd;

  ProductOrderParkModel({required this.id, required this.totalTime, required this.totalPrice, required this.parkingTimeStart, required this.parkingTimeEnd});

  factory ProductOrderParkModel.fromJson(Map<String, dynamic> json) {
    return ProductOrderParkModel(
      id: json['id'] ?? 0,
      totalTime: json['totalTime'] ?? 0,
      totalPrice: json['totalPrice'] ?? 0,
      parkingTimeStart: json['parkingTimeStart'] ?? '',
      parkingTimeEnd: json['parkingTimeEnd'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'totalTime': totalTime,
      'totalPrice': totalPrice,
      'parkingTimeStart': parkingTimeStart,
      'parkingTimeEnd': parkingTimeEnd,
    };
  }


}
