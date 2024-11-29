// To parse this JSON data, do
//
//     final listLemburModel = listLemburModelFromJson(jsonString);

import 'dart:convert';

import 'package:esas/app/data/org_model.dart';
import 'package:esas/app/data/user/user_model.dart';

List<LemburModel> listLemburModelFromJson(String str) => List<LemburModel>.from(
    json.decode(str).map((x) => LemburModel.fromJson(x)));

String listLemburModelToJson(List<LemburModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LemburModel {
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
  UserModel? user;
  OrgModel? org;
  OrgModel? position;

  LemburModel({
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

  factory LemburModel.fromJson(Map<String, dynamic> json) => LemburModel(
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
        user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
        org: json["org"] == null ? null : OrgModel.fromJson(json["org"]),
        position: json["position"] == null
            ? null
            : OrgModel.fromJson(json["position"]),
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
