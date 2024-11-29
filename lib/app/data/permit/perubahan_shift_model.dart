// To parse this JSON data, do
//
//     final listPerubahanShifyModel = listPerubahanShifyModelFromJson(jsonString);

import 'dart:convert';

import 'package:esas/app/data/presence/group_absensi_model.dart';
import 'package:esas/app/data/presence/group_shift_model.dart';
import 'package:esas/app/data/user/user_model.dart';

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
  GroupAbsensiModel? group;
  GroupShiftModel? currentshift;
  GroupShiftModel? adjustshift;
  UserModel? user;
  UserModel? line;
  UserModel? hr;

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
        group: json["group"] == null
            ? null
            : GroupAbsensiModel.fromJson(json["group"]),
        currentshift: json["currentshift"] == null
            ? null
            : GroupShiftModel.fromJson(json["currentshift"]),
        adjustshift: json["adjustshift"] == null
            ? null
            : GroupShiftModel.fromJson(json["adjustshift"]),
        user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
        line: json["line"] == null ? null : UserModel.fromJson(json["line"]),
        hr: json["hr"] == null ? null : UserModel.fromJson(json["hr"]),
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
