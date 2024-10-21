// To parse this JSON data, do
//
//     final accountScheduleModel = accountScheduleModelFromJson(jsonString);

import 'dart:convert';

AccountScheduleModel accountScheduleModelFromJson(String str) =>
    AccountScheduleModel.fromJson(json.decode(str));

String accountScheduleModelToJson(AccountScheduleModel data) =>
    json.encode(data.toJson());

class AccountScheduleModel {
  int? id;
  int? groupAttendanceId;
  int? userId;
  int? timeAttendanceId;
  DateTime? date;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  Time? time;
  GroupAttendance? groupAttendance;
  User? user;

  AccountScheduleModel({
    this.id,
    this.groupAttendanceId,
    this.userId,
    this.timeAttendanceId,
    this.date,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.time,
    this.groupAttendance,
    this.user,
  });

  factory AccountScheduleModel.fromJson(Map<String, dynamic> json) =>
      AccountScheduleModel(
        id: json["id"],
        groupAttendanceId: json["groupAttendanceId"],
        userId: json["userId"],
        timeAttendanceId: json["timeAttendanceId"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        status: json["status"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        time: json["time"] == null ? null : Time.fromJson(json["time"]),
        groupAttendance: json["group_attendance"] == null
            ? null
            : GroupAttendance.fromJson(json["group_attendance"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "groupAttendanceId": groupAttendanceId,
        "userId": userId,
        "timeAttendanceId": timeAttendanceId,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "time": time?.toJson(),
        "group_attendance": groupAttendance?.toJson(),
        "user": user?.toJson(),
      };
}

class GroupAttendance {
  int? id;
  String? name;
  String? description;
  String? patternName;

  GroupAttendance({
    this.id,
    this.name,
    this.description,
    this.patternName,
  });

  factory GroupAttendance.fromJson(Map<String, dynamic> json) =>
      GroupAttendance(
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

class Time {
  int? id;
  String? type;
  String? timeIn;
  String? out;
  String? patternName;
  dynamic rules;

  Time({
    this.id,
    this.type,
    this.timeIn,
    this.out,
    this.patternName,
    this.rules,
  });

  factory Time.fromJson(Map<String, dynamic> json) => Time(
        id: json["id"],
        type: json["type"],
        timeIn: json["in"],
        out: json["out"],
        patternName: json["patternName"],
        rules: json["rules"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "in": timeIn,
        "out": out,
        "patternName": patternName,
        "rules": rules,
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
