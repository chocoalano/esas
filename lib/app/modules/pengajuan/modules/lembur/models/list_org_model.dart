// To parse this JSON data, do
//
//     final listOrgModel = listOrgModelFromJson(jsonString);

import 'dart:convert';

List<ListOrgModel> listOrgModelFromJson(String str) => List<ListOrgModel>.from(
    json.decode(str).map((x) => ListOrgModel.fromJson(x)));

String listOrgModelToJson(List<ListOrgModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListOrgModel {
  int? id;
  String? name;
  String? description;

  ListOrgModel({
    this.id,
    this.name,
    this.description,
  });

  factory ListOrgModel.fromJson(Map<String, dynamic> json) => ListOrgModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
      };
}
