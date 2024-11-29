// To parse this JSON data, do
//
//     final anouncementModel = anouncementModelFromJson(jsonString);

import 'dart:convert';

import 'package:esas/app/data/user/user_model.dart';

List<AnouncementModel> anouncementModelFromJson(String str) =>
    List<AnouncementModel>.from(
        json.decode(str).map((x) => AnouncementModel.fromJson(x)));

String anouncementModelToJson(List<AnouncementModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AnouncementModel {
  int? id;
  int? createdBy;
  String? title;
  String? value;
  bool? publish;
  DateTime? createdAt;
  DateTime? updatedAt;
  UserModel? userCreatedBy;

  AnouncementModel({
    this.id,
    this.createdBy,
    this.title,
    this.value,
    this.publish,
    this.createdAt,
    this.updatedAt,
    this.userCreatedBy,
  });

  factory AnouncementModel.fromJson(Map<String, dynamic> json) =>
      AnouncementModel(
        id: json["id"],
        createdBy: json["createdBy"],
        title: json["title"],
        value: json["value"],
        publish: json["publish"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        userCreatedBy: json["user_created_by"] == null
            ? null
            : UserModel.fromJson(json["user_created_by"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdBy": createdBy,
        "title": title,
        "value": value,
        "publish": publish,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "user_created_by": userCreatedBy?.toJson(),
      };
}
