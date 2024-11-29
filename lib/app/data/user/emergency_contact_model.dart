class EmergencyContactModel {
  int? id;
  int? userId;
  String? name;
  String? relationship;
  String? phone;
  String? profesion;

  EmergencyContactModel({
    this.id,
    this.userId,
    this.name,
    this.relationship,
    this.phone,
    this.profesion,
  });

  factory EmergencyContactModel.fromJson(Map<String, dynamic> json) =>
      EmergencyContactModel(
        id: json["id"],
        userId: json["userId"],
        name: json["name"],
        relationship: json["relationship"],
        phone: json["phone"],
        profesion: json["profesion"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "name": name,
        "relationship": relationship,
        "phone": phone,
        "profesion": profesion,
      };
}
