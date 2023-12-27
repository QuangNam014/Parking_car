class UpdateProductInforModel {
  final int id;
  final int totalSlot;
  final double price;

  UpdateProductInforModel({required this.id, required this.totalSlot, required this.price});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'totalSlot': totalSlot,
      'price': price,
    };
  }
}