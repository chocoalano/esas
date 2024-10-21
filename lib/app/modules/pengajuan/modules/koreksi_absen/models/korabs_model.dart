// To parse this JSON data, do
//
//     final koreksiAbsenModel = koreksiAbsenModelFromJson(jsonString);

import 'dart:convert';

List<KoreksiAbsenModel> koreksiAbsenModelFromJson(String str) =>
    List<KoreksiAbsenModel>.from(
        json.decode(str).map((x) => KoreksiAbsenModel.fromJson(x)));

String koreksiAbsenModelToJson(List<KoreksiAbsenModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class KoreksiAbsenModel {
  int? id;
  int? userId;
  DateTime? dateAdjustment;
  String? timeinAdjustment;
  String? timeoutAdjustment;
  String? notes;
  String? status;
  int? lineId;
  String? lineApprove;
  int? hrId;
  String? hrApprove;
  DateTime? createdAt;
  DateTime? updatedAt;
  Hrd? user;
  Hrd? line;
  Hrd? hrd;

  KoreksiAbsenModel({
    this.id,
    this.userId,
    this.dateAdjustment,
    this.timeinAdjustment,
    this.timeoutAdjustment,
    this.notes,
    this.status,
    this.lineId,
    this.lineApprove,
    this.hrId,
    this.hrApprove,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.line,
    this.hrd,
  });

  factory KoreksiAbsenModel.fromJson(Map<String, dynamic> json) =>
      KoreksiAbsenModel(
        id: json["id"],
        userId: json["userId"],
        dateAdjustment: json["dateAdjustment"] == null
            ? null
            : DateTime.parse(json["dateAdjustment"]),
        timeinAdjustment: json["timeinAdjustment"],
        timeoutAdjustment: json["timeoutAdjustment"],
        notes: json["notes"],
        status: json["status"],
        lineId: json["lineId"],
        lineApprove: json["lineApprove"],
        hrId: json["hrId"],
        hrApprove: json["hrApprove"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        user: json["user"] == null ? null : Hrd.fromJson(json["user"]),
        line: json["line"] == null ? null : Hrd.fromJson(json["line"]),
        hrd: json["hrd"] == null ? null : Hrd.fromJson(json["hrd"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "dateAdjustment":
            "${dateAdjustment!.year.toString().padLeft(4, '0')}-${dateAdjustment!.month.toString().padLeft(2, '0')}-${dateAdjustment!.day.toString().padLeft(2, '0')}",
        "timeinAdjustment": timeinAdjustment,
        "timeoutAdjustment": timeoutAdjustment,
        "notes": notes,
        "status": status,
        "lineId": lineId,
        "lineApprove": lineApprove,
        "hrId": hrId,
        "hrApprove": hrApprove,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "user": user?.toJson(),
        "line": line?.toJson(),
        "hrd": hrd?.toJson(),
      };
}

class Hrd {
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

  Hrd({
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

  factory Hrd.fromJson(Map<String, dynamic> json) => Hrd(
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
