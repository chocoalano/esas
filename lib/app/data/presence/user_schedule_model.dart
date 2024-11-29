// To parse this JSON data, do
//
//     final accountScheduleModel = accountScheduleModelFromJson(jsonString);

import 'dart:convert';

import 'package:esas/app/data/presence/group_absensi_model.dart';
import 'package:esas/app/data/presence/time_model.dart';
import 'package:esas/app/data/user/user_model.dart';

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
  TimeModel? time;
  GroupAbsensiModel? groupAttendance;
  UserModel? user;

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
        time: json["time"] == null ? null : TimeModel.fromJson(json["time"]),
        groupAttendance: json["group_attendance"] == null
            ? null
            : GroupAbsensiModel.fromJson(json["group_attendance"]),
        user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
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
