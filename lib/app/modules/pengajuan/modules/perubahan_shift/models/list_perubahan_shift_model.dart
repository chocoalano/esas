// To parse this JSON data, do
//
//     final listPerubahanShifyModel = listPerubahanShifyModelFromJson(jsonString);

import 'dart:convert';

List<ListPerubahanShifyModel> listPerubahanShifyModelFromJson(String str) =>
    List<ListPerubahanShifyModel>.from(
        json.decode(str).map((x) => ListPerubahanShifyModel.fromJson(x)));

String listPerubahanShifyModelToJson(List<ListPerubahanShifyModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListPerubahanShifyModel {
  int? id;
  int? userId;
  DateTime? date;
  int? currentGroup;
  int? currentShift;
  int? adjustShift;
  String? status;
  int? lineId;
  String? lineApprove;
  int? hrId;
  String? hrApprove;
  DateTime? createdAt;
  DateTime? updatedAt;
  Hr? user;
  Hr? line;
  Hr? hr;

  ListPerubahanShifyModel({
    this.id,
    this.userId,
    this.date,
    this.currentGroup,
    this.currentShift,
    this.adjustShift,
    this.status,
    this.lineId,
    this.lineApprove,
    this.hrId,
    this.hrApprove,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.line,
    this.hr,
  });

  factory ListPerubahanShifyModel.fromJson(Map<String, dynamic> json) =>
      ListPerubahanShifyModel(
        id: json["id"],
        userId: json["userId"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        currentGroup: json["currentGroup"],
        currentShift: json["currentShift"],
        adjustShift: json["adjustShift"],
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
        user: json["user"] == null ? null : Hr.fromJson(json["user"]),
        line: json["line"] == null ? null : Hr.fromJson(json["line"]),
        hr: json["hr"] == null ? null : Hr.fromJson(json["hr"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "currentGroup": currentGroup,
        "currentShift": currentShift,
        "adjustShift": adjustShift,
        "status": status,
        "lineId": lineId,
        "lineApprove": lineApprove,
        "hrId": hrId,
        "hrApprove": hrApprove,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "user": user?.toJson(),
        "line": line?.toJson(),
        "hr": hr?.toJson(),
      };
}

class Hr {
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

  Hr({
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

  factory Hr.fromJson(Map<String, dynamic> json) => Hr(
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
