// To parse this JSON data, do
//
//     final lineModel = lineModelFromJson(jsonString);

import 'dart:convert';

List<LineModel> lineModelFromJson(String str) =>
    List<LineModel>.from(json.decode(str).map((x) => LineModel.fromJson(x)));

String lineModelToJson(List<LineModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LineModel {
  int? id;
  String? name;
  dynamic nik;
  String? email;
  dynamic phone;
  dynamic placebirth;
  dynamic datebirth;
  dynamic gender;
  dynamic blood;
  dynamic maritalStatus;
  dynamic religion;
  dynamic image;

  LineModel({
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

  factory LineModel.fromJson(Map<String, dynamic> json) => LineModel(
        id: json["id"],
        name: json["name"],
        nik: json["nik"],
        email: json["email"],
        phone: json["phone"],
        placebirth: json["placebirth"],
        datebirth: json["datebirth"],
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
        "datebirth": datebirth,
        "gender": gender,
        "blood": blood,
        "maritalStatus": maritalStatus,
        "religion": religion,
        "image": image,
      };
}
