import 'package:app/features/models/supplier/infor_image_model.dart';

class UpdateProductImageModel {
  final int id;
  final List<InforImageModel> listImage;

  UpdateProductImageModel({required this.id, required this.listImage});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'listImage': listImage.map((v) => v.toJson()).toList(),
    };
  }
}