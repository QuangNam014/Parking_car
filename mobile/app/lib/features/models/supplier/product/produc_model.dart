import 'package:app/features/models/supplier/infor_image_model.dart';

class ProductModel {
  final int? id;
  final double price;
  final int totalSlot;
  final String? status;
  final String city;
  final String district;
  final String ward;
  final String street;
  final String longitude;
  final String latitude;
  List<InforImageModel> listImage;

  ProductModel({
    this.id,
    this.status,
    required this.price,
    required this.totalSlot,
    required this.city,
    required this.district,
    required this.ward,
    required this.street,
    required this.longitude,
    required this.latitude,
    required this.listImage
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    List<InforImageModel> parsedListImage = [];
    if (json['listImage'] != null) {
      var list = json['listImage'] as List;
      parsedListImage = list.map((v) => InforImageModel.fromJson(v)).toList();
    }
    return ProductModel(
      id: json['id'] ?? 0,
      price: json['price'] ?? 0,
      totalSlot: json['totalSlot'] ?? 0,
      status: json['status'] ?? '',
      city: json['city'] ?? '',
      district: json['district'] ?? '',
      ward: json['ward'] ?? '',
      street: json['street'] ?? '',
      longitude: json['longitude'] ?? '',
      latitude: json['latitude'] ?? '',
      listImage: parsedListImage,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'price': price,
      'totalSlot': totalSlot,
      'city': city,
      'district': district,
      'ward': ward,
      'street': street,
      'longitude': longitude,
      'latitude': latitude,
      'listImage': listImage.map((v) => v.toJson()).toList(),
    };
  }
}

