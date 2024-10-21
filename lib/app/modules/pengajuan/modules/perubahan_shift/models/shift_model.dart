// To parse this JSON data, do
//
//     final groupShiftModel = groupShiftModelFromJson(jsonString);

import 'dart:convert';

List<GroupShiftModel> groupShiftModelFromJson(String str) =>
    List<GroupShiftModel>.from(
        json.decode(str).map((x) => GroupShiftModel.fromJson(x)));

String groupShiftModelToJson(List<GroupShiftModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GroupShiftModel {
  int? id;
  String? type;
  String? groupShiftModelIn;
  String? out;
  String? patternName;
  int? rules;

  GroupShiftModel({
    this.id,
    this.type,
    this.groupShiftModelIn,
    this.out,
    this.patternName,
    this.rules,
  });

  factory GroupShiftModel.fromJson(Map<String, dynamic> json) =>
      GroupShiftModel(
        id: json["id"],
        type: json["type"],
        groupShiftModelIn: json["in"],
        out: json["out"],
        patternName: json["patternName"],
        rules: json["rules"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "in": groupShiftModelIn,
        "out": out,
        "patternName": patternName,
        "rules": rules,
      };
}
