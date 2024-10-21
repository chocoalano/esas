// To parse this JSON data, do
//
//     final groupAbsensiModel = groupAbsensiModelFromJson(jsonString);

import 'dart:convert';

List<GroupAbsensiModel> groupAbsensiModelFromJson(String str) =>
    List<GroupAbsensiModel>.from(
        json.decode(str).map((x) => GroupAbsensiModel.fromJson(x)));

String groupAbsensiModelToJson(List<GroupAbsensiModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GroupAbsensiModel {
  int? id;
  String? name;
  String? description;
  String? patternName;

  GroupAbsensiModel({
    this.id,
    this.name,
    this.description,
    this.patternName,
  });

  factory GroupAbsensiModel.fromJson(Map<String, dynamic> json) =>
      GroupAbsensiModel(
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
