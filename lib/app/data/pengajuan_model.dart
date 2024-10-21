// To parse this JSON data, do
//
//     final PengajuanModel = pengajuanModelFromJson(jsonString);

import 'dart:convert';

List<PengajuanModel> pengajuanModelFromJson(String str) =>
    List<PengajuanModel>.from(
        json.decode(str).map((x) => PengajuanModel.fromJson(x)));

String pengajuanModelToJson(List<PengajuanModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PengajuanModel {
  String? tablename;
  int? id;
  int? userCreated;
  int? user1;
  int? user2;
  dynamic user3;
  dynamic user4;
  dynamic user5;
  dynamic user6;
  String? status1;
  String? status2;
  dynamic status3;
  dynamic status4;
  dynamic status5;
  dynamic status6;
  User? user;

  PengajuanModel({
    this.tablename,
    this.id,
    this.userCreated,
    this.user1,
    this.user2,
    this.user3,
    this.user4,
    this.user5,
    this.user6,
    this.status1,
    this.status2,
    this.status3,
    this.status4,
    this.status5,
    this.status6,
    this.user,
  });

  factory PengajuanModel.fromJson(Map<String, dynamic> json) => PengajuanModel(
        tablename: json["tablename"],
        id: json["id"],
        userCreated: json["userCreated"],
        user1: json["user1"],
        user2: json["user2"],
        user3: json["user3"],
        user4: json["user4"],
        user5: json["user5"],
        user6: json["user6"],
        status1: json["status1"],
        status2: json["status2"],
        status3: json["status3"],
        status4: json["status4"],
        status5: json["status5"],
        status6: json["status6"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "tablename": tablename,
        "id": id,
        "userCreated": userCreated,
        "user1": user1,
        "user2": user2,
        "user3": user3,
        "user4": user4,
        "user5": user5,
        "user6": user6,
        "status1": status1,
        "status2": status2,
        "status3": status3,
        "status4": status4,
        "status5": status5,
        "status6": status6,
        "user": user?.toJson(),
      };
}

class User {
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

  User({
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

  factory User.fromJson(Map<String, dynamic> json) => User(
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
