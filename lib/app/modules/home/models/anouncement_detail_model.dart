import 'dart:convert';

AnouncementDetailModel anouncementDetailModelFromJson(String str) =>
    AnouncementDetailModel.fromJson(json.decode(str));

String anouncementDetailModelToJson(AnouncementDetailModel data) =>
    json.encode(data.toJson());

class AnouncementDetailModel {
  int? id;
  int? createdBy;
  String? title;
  String? value;
  bool? publish;
  DateTime? createdAt;
  DateTime? updatedAt;

  AnouncementDetailModel({
    this.id,
    this.createdBy,
    this.title,
    this.value,
    this.publish,
    this.createdAt,
    this.updatedAt,
  });

  factory AnouncementDetailModel.fromJson(Map<String, dynamic> json) =>
      AnouncementDetailModel(
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
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdBy": createdBy,
        "title": title,
        "value": value,
        "publish": publish,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
