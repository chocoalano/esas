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
  Group? group;
  Tshift? currentshift;
  Tshift? adjustshift;
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
    this.group,
    this.currentshift,
    this.adjustshift,
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
        group: json["group"] == null ? null : Group.fromJson(json["group"]),
        currentshift: json["currentshift"] == null
            ? null
            : Tshift.fromJson(json["currentshift"]),
        adjustshift: json["adjustshift"] == null
            ? null
            : Tshift.fromJson(json["adjustshift"]),
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
        "group": group?.toJson(),
        "currentshift": currentshift?.toJson(),
        "adjustshift": adjustshift?.toJson(),
        "user": user?.toJson(),
        "line": line?.toJson(),
        "hr": hr?.toJson(),
      };
}

class Tshift {
  int? id;
  String? type;
  String? tshiftIn;
  String? out;
  String? patternName;
  int? rules;

  Tshift({
    this.id,
    this.type,
    this.tshiftIn,
    this.out,
    this.patternName,
    this.rules,
  });

  factory Tshift.fromJson(Map<String, dynamic> json) => Tshift(
        id: json["id"],
        type: json["type"],
        tshiftIn: json["in"],
        out: json["out"],
        patternName: json["patternName"],
        rules: json["rules"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "in": tshiftIn,
        "out": out,
        "patternName": patternName,
        "rules": rules,
      };
}

class Group {
  int? id;
  String? name;
  String? description;
  String? patternName;

  Group({
    this.id,
    this.name,
    this.description,
    this.patternName,
  });

  factory Group.fromJson(Map<String, dynamic> json) => Group(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        patternName: json["patternName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "patternName": patternName,
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
