// To parse this JSON data, do
//
//     final listPositionModel = listPositionModelFromJson(jsonString);

import 'dart:convert';

List<ListPositionModel> listPositionModelFromJson(String str) =>
    List<ListPositionModel>.from(
        json.decode(str).map((x) => ListPositionModel.fromJson(x)));

String listPositionModelToJson(List<ListPositionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListPositionModel {
  int? id;
  String? name;
  String? description;

  ListPositionModel({
    this.id,
    this.name,
    this.description,
  });

  factory ListPositionModel.fromJson(Map<String, dynamic> json) =>
      ListPositionModel(
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
