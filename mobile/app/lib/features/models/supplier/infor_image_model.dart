class InforImageModel {
  final String name;
  final String url;

  InforImageModel({required this.name, required this.url});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
    };
  }

  factory InforImageModel.fromJson(Map<String, dynamic> data) {
    return InforImageModel(
      name: data['public_id'] ?? "",
      url: data['secure_url'] ?? "",
    );
  }
}