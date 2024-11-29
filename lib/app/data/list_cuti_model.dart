// To parse this JSON data, do
//
//     final listCutiModel = listCutiModelFromJson(jsonString);

import 'dart:convert';

import 'package:esas/app/data/user/user_model.dart';

List<ListCutiModel> listCutiModelFromJson(String str) =>
    List<ListCutiModel>.from(
        json.decode(str).map((x) => ListCutiModel.fromJson(x)));

String listCutiModelToJson(List<ListCutiModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListCutiModel {
  int? id;
  int? userId;
  DateTime? startDate;
  DateTime? endDate;
  String? startTime;
  String? endTime;
  String? category;
  String? type;
  String? description;
  String? userApproved;
  int? userLine;
  String? lineApproved;
  int? userHr;
  String? hrgaApproved;
  DateTime? createdAt;
  DateTime? updatedAt;
  UserModel? user;
  UserModel? line;
  UserModel? hrga;

  ListCutiModel({
    this.id,
    this.userId,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    this.category,
    this.type,
    this.description,
    this.userApproved,
    this.userLine,
    this.lineApproved,
    this.userHr,
    this.hrgaApproved,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.line,
    this.hrga,
  });

  factory ListCutiModel.fromJson(Map<String, dynamic> json) => ListCutiModel(
        id: json["id"],
        userId: json["userId"],
        startDate: json["startDate"] == null
            ? null
            : DateTime.parse(json["startDate"]),
        endDate:
            json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
        startTime: json["startTime"],
        endTime: json["endTime"],
        category: json["category"],
        type: json["type"],
        description: json["description"],
        userApproved: json["userApproved"],
        userLine: json["userLine"],
        lineApproved: json["lineApproved"],
        userHr: json["userHr"],
        hrgaApproved: json["hrgaApproved"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
        line: json["line"] == null ? null : UserModel.fromJson(json["line"]),
        hrga: json["hrga"] == null ? null : UserModel.fromJson(json["hrga"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "startDate":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "endDate":
            "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "startTime": startTime,
        "endTime": endTime,
        "category": category,
        "type": type,
        "description": description,
        "userApproved": userApproved,
        "userLine": userLine,
        "lineApproved": lineApproved,
        "userHr": userHr,
        "hrgaApproved": hrgaApproved,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "user": user?.toJson(),
        "line": line?.toJson(),
        "hrga": hrga?.toJson(),
      };
}
