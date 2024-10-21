// To parse this JSON data, do
//
//     final hrdOptionsModel = hrdOptionsModelFromJson(jsonString);

import 'dart:convert';

List<HrdOptionsModel> hrdOptionsModelFromJson(String str) =>
    List<HrdOptionsModel>.from(
        json.decode(str).map((x) => HrdOptionsModel.fromJson(x)));

String hrdOptionsModelToJson(List<HrdOptionsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HrdOptionsModel {
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

  HrdOptionsModel({
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

  factory HrdOptionsModel.fromJson(Map<String, dynamic> json) =>
      HrdOptionsModel(
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
