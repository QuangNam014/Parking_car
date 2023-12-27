class StatusModel {
  final int id;
  final String status;

  StatusModel({required this.id, required this.status});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
    };
  }

  factory StatusModel.fromJson(Map<String, dynamic> data) {
    return StatusModel(
      id: data['id'] ?? 0,
      status: data['status'] ?? "",
    );
  }
}