// To parse this JSON data, do
//
//     final listLemburModel = listLemburModelFromJson(jsonString);

import 'dart:convert';

List<ListLemburModel> listLemburModelFromJson(String str) =>
    List<ListLemburModel>.from(
        json.decode(str).map((x) => ListLemburModel.fromJson(x)));

String listLemburModelToJson(List<ListLemburModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListLemburModel {
  int? id;
  int? useridCreated;
  DateTime? dateSpl;
  int? organizationId;
  int? jobPositionId;
  int? overtimeDayStatus;
  DateTime? dateOvertimeAt;
  dynamic userAdm;
  String? adminApproved;
  dynamic userLine;
  String? lineApproved;
  dynamic userGm;
  String? gmApproved;
  dynamic userHr;
  String? hrgaApproved;
  dynamic userDirector;
  String? directorApproved;
  dynamic userFat;
  String? fatApproved;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? user;
  Org? org;
  Org? position;

  ListLemburModel({
    this.id,
    this.useridCreated,
    this.dateSpl,
    this.organizationId,
    this.jobPositionId,
    this.overtimeDayStatus,
    this.dateOvertimeAt,
    this.userAdm,
    this.adminApproved,
    this.userLine,
    this.lineApproved,
    this.userGm,
    this.gmApproved,
    this.userHr,
    this.hrgaApproved,
    this.userDirector,
    this.directorApproved,
    this.userFat,
    this.fatApproved,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.org,
    this.position,
  });

  factory ListLemburModel.fromJson(Map<String, dynamic> json) =>
      ListLemburModel(
        id: json["id"],
        useridCreated: json["useridCreated"],
        dateSpl:
            json["dateSpl"] == null ? null : DateTime.parse(json["dateSpl"]),
        organizationId: json["organizationId"],
        jobPositionId: json["jobPositionId"],
        overtimeDayStatus: json["overtimeDayStatus"],
        dateOvertimeAt: json["dateOvertimeAt"] == null
            ? null
            : DateTime.parse(json["dateOvertimeAt"]),
        userAdm: json["userAdm"],
        adminApproved: json["adminApproved"],
        userLine: json["userLine"],
        lineApproved: json["lineApproved"],
        userGm: json["userGm"],
        gmApproved: json["gmApproved"],
        userHr: json["userHr"],
        hrgaApproved: json["hrgaApproved"],
        userDirector: json["userDirector"],
        directorApproved: json["directorApproved"],
        userFat: json["userFat"],
        fatApproved: json["fatApproved"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        org: json["org"] == null ? null : Org.fromJson(json["org"]),
        position:
            json["position"] == null ? null : Org.fromJson(json["position"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "useridCreated": useridCreated,
        "dateSpl":
            "${dateSpl!.year.toString().padLeft(4, '0')}-${dateSpl!.month.toString().padLeft(2, '0')}-${dateSpl!.day.toString().padLeft(2, '0')}",
        "organizationId": organizationId,
        "jobPositionId": jobPositionId,
        "overtimeDayStatus": overtimeDayStatus,
        "dateOvertimeAt":
            "${dateOvertimeAt!.year.toString().padLeft(4, '0')}-${dateOvertimeAt!.month.toString().padLeft(2, '0')}-${dateOvertimeAt!.day.toString().padLeft(2, '0')}",
        "userAdm": userAdm,
        "adminApproved": adminApproved,
        "userLine": userLine,
        "lineApproved": lineApproved,
        "userGm": userGm,
        "gmApproved": gmApproved,
        "userHr": userHr,
        "hrgaApproved": hrgaApproved,
        "userDirector": userDirector,
        "directorApproved": directorApproved,
        "userFat": userFat,
        "fatApproved": fatApproved,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "user": user?.toJson(),
        "org": org?.toJson(),
        "position": position?.toJson(),
      };
}

class Org {
  int? id;
  String? name;
  String? description;

  Org({
    this.id,
    this.name,
    this.description,
  });

  factory Org.fromJson(Map<String, dynamic> json) => Org(
        id: json["id"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
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
