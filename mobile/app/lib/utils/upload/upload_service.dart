import 'dart:convert';

import 'package:app/features/models/supplier/infor_image_model.dart';
import 'package:http/http.dart' as http;

class UploadService {

  final uri = "https://api.cloudinary.com/v1_1/dpnkkp6rl/upload";

  Future<void> uploadImage(String imagePath) async {
    try {
      final url = Uri.parse(uri);
      if(imagePath.isNotEmpty) {
        var request = http.MultipartRequest('POST', url)
          ..fields['upload_preset'] = 'upload-image-project'
          ..files.add(await http.MultipartFile.fromPath('file', imagePath));
        var response = await request.send();
        if (response.statusCode == 200) {
          // Xử lý phản hồi từ Cloudinary sau khi upload thành công.
          String responseData = await response.stream.bytesToString();
          Map<String, dynamic> jsonData = json.decode(responseData);
          InforImageModel imageModel = InforImageModel.fromJson(jsonData);
          print("name: ${imageModel.name} --- url: ${imageModel.url}");
          print('Image uploaded successfully!');
        } else {
          print('Failed to upload image. Status code: ${response.statusCode}');
        }
      } else {
        print('No data');
      }
    } catch (error) {
      print('Error uploading image: $error');
    }
  }
  
  Future<void> uploadMultiImage(List<String> imagePaths) async {
    try {
      final url = Uri.parse(uri);

      List<InforImageModel> listImage = [];

      if(imagePaths.isNotEmpty) {
        for (String imagePath in imagePaths) {
          var request = http.MultipartRequest('POST', url)
            ..fields['upload_preset'] = 'upload-image-project'
            ..files.add(await http.MultipartFile.fromPath('file', imagePath));
          var response = await request.send();
          if (response.statusCode == 200) {
            // Xử lý phản hồi từ Cloudinary sau khi upload thành công.
            String responseData = await response.stream.bytesToString();
            Map<String, dynamic> jsonData = json.decode(responseData);
            InforImageModel imageModel = InforImageModel.fromJson(jsonData);
            listImage.add(imageModel);
            print('Image uploaded successfully!');
          } else {
            print('Failed to upload image. Status code: ${response.statusCode}');
          }
        }
      } else {
        print('No data');
      }
    } catch (error) {
      // Xử lý lỗi nếu có.
      print('Error uploading image: $error');
    }
  }
}