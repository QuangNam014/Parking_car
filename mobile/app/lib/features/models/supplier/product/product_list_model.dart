
class ProductListModel {
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
  List<ProductImageModel> listImage;

  ProductListModel({
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

   factory ProductListModel.fromJson(Map<String, dynamic> json) {
    List<ProductImageModel> parsedListImage = [];
    if (json['listImage'] != null) {
      var list = json['listImage'] as List;
      parsedListImage = list.map((v) => ProductImageModel.fromJson(v)).toList();
    }
    return ProductListModel(
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

class ProductImageModel {
  final String name;
  final String url;

  ProductImageModel({required this.name, required this.url});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
    };
  }

  factory ProductImageModel.fromJson(Map<String, dynamic> data) {
    return ProductImageModel(
      name: data['name'] ?? "",
      url: data['url'] ?? "",
    );
  }
}
