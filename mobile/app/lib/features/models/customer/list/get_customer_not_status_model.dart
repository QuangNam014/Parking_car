import 'package:app/features/models/supplier/product/product_list_model.dart';

class GetDataCustomerNotStatusModel {
  final int id;
  final String parkingTimeStart;
  final String parkingTimeEnd;
  final int totalTime;
  final double totalPrice;

  final String city;
  final String district;
  final String ward;
  final String street;

  final String fullname;
  final String userDocument;
  final String userLicense;
  final String status;

  ProductImageModel image;

  GetDataCustomerNotStatusModel({
    required this.id, 
    required this.parkingTimeStart, 
    required this.parkingTimeEnd, 
    required this.totalTime, 
    required this.totalPrice, 
    required this.city, 
    required this.district, 
    required this.ward, 
    required this.street, 
    required this.fullname, 
    required this.userDocument, 
    required this.userLicense, 
    required this.status,
    required this.image
  });

  factory GetDataCustomerNotStatusModel.fromJson(Map<String, dynamic> json) {
    return GetDataCustomerNotStatusModel(
      id: json['id'] ?? 0,
      parkingTimeStart: json['parkingTimeStart'] ?? '',
      parkingTimeEnd: json['parkingTimeEnd'] ?? '',
      totalTime: json['totalTime'] ?? 0,
      totalPrice: json['totalPrice'] ?? 0,
      city: json['city'] ?? '',
      district: json['district'] ?? '',
      ward: json['ward'] ?? '',
      street: json['street'] ?? '',
      fullname: json['fullname'] ?? '',
      userDocument: json['userDocument'] ?? '',
      userLicense: json['userLicense'] ?? '',
      status: json['status'] ?? '',
      image: ProductImageModel.fromJson(json['image']),
    );
  }
}