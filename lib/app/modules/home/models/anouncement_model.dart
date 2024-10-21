// To parse this JSON data, do
//
//     final anouncementModel = anouncementModelFromJson(jsonString);

import 'dart:convert';

List<AnouncementModel> anouncementModelFromJson(String str) =>
    List<AnouncementModel>.from(
        json.decode(str).map((x) => AnouncementModel.fromJson(x)));

String anouncementModelToJson(List<AnouncementModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AnouncementModel {
  int? id;
  int? createdBy;
  String? title;
  String? value;
  bool? publish;
  DateTime? createdAt;
  DateTime? updatedAt;
  UserCreatedBy? userCreatedBy;

  AnouncementModel({
    this.id,
    this.createdBy,
    this.title,
    this.value,
    this.publish,
    this.createdAt,
    this.updatedAt,
    this.userCreatedBy,
  });

  factory AnouncementModel.fromJson(Map<String, dynamic> json) =>
      AnouncementModel(
        id: json["id"],
        createdBy: json["createdBy"],
        title: json["title"],
        value: json["value"],
        publish: json["publish"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        userCreatedBy: json["user_created_by"] == null
            ? null
            : UserCreatedBy.fromJson(json["user_created_by"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdBy": createdBy,
        "title": title,
        "value": value,
        "publish": publish,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "user_created_by": userCreatedBy?.toJson(),
      };
}

class UserCreatedBy {
  int? id;
  String? name;
  String? nik;
  String? email;
  String? phone;
  String? placebirth;
  DateTime? datebirth;
  String? gender;
  String? blood;
  String? maritalStatus;
  String? religion;
  String? image;

  UserCreatedBy({
    this.id,
    this.name,
    this.nik,
    this.email,
    this.phone,
    this.placebirth,
    this.datebirth,
    this.gender,
    this.blood,
    this.maritalStatus,
    this.religion,
    this.image,
  });

  factory UserCreatedBy.fromJson(Map<String, dynamic> json) => UserCreatedBy(
        id: json["id"],
        name: json["name"],
        nik: json["nik"],
        email: json["email"],
        phone: json["phone"],
        placebirth: json["placebirth"],
        datebirth: json["datebirth"] == null
            ? null
            : DateTime.parse(json["datebirth"]),
        gender: json["gender"],
        blood: json["blood"],
        maritalStatus: json["maritalStatus"],
        religion: json["religion"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "nik": nik,
        "email": email,
        "phone": phone,
        "placebirth": placebirth,
        "datebirth":
            "${datebirth!.year.toString().padLeft(4, '0')}-${datebirth!.month.toString().padLeft(2, '0')}-${datebirth!.day.toString().padLeft(2, '0')}",
        "gender": gender,
        "blood": blood,
        "maritalStatus": maritalStatus,
        "religion": religion,
        "image": image,
      };
}
