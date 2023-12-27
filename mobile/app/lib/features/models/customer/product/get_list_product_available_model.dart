import 'package:app/features/models/supplier/product/product_list_model.dart';

class GetListProductAvaiLableModel {
  final int? id;
  final double price;
  final int totalSlot;
  final String city;
  final String district;
  final String ward;
  final String street;
  final String longitude;
  final String latitude;
  ProductImageModel image;

  GetListProductAvaiLableModel({
    this.id,
    required this.price,
    required this.totalSlot,
    required this.city,
    required this.district,
    required this.ward,
    required this.street,
    required this.longitude,
    required this.latitude,
    required this.image
  });

   factory GetListProductAvaiLableModel.fromJson(Map<String, dynamic> json) {
    
    return GetListProductAvaiLableModel(
      id: json['id'] ?? 0,
      price: json['price'] ?? 0,
      totalSlot: json['totalSlot'] ?? 0,
      city: json['city'] ?? '',
      district: json['district'] ?? '',
      ward: json['ward'] ?? '',
      street: json['street'] ?? '',
      longitude: json['longitude'] ?? '',
      latitude: json['latitude'] ?? '',
      image: ProductImageModel.fromJson(json['image']),
    );
  }
}

