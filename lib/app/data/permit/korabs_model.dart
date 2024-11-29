// To parse this JSON data, do
//
//     final koreksiAbsenModel = koreksiAbsenModelFromJson(jsonString);

import 'dart:convert';

import 'package:esas/app/data/user/user_model.dart';

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
  UserModel? user;
  UserModel? line;
  UserModel? hrd;

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
        user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
        line: json["line"] == null ? null : UserModel.fromJson(json["line"]),
        hrd: json["hrd"] == null ? null : UserModel.fromJson(json["hrd"]),
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
