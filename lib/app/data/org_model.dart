import 'dart:convert';

List<OrgModel> listOrgModelFromJson(String str) =>
    List<OrgModel>.from(json.decode(str).map((x) => OrgModel.fromJson(x)));

String listOrgModelToJson(List<OrgModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrgModel {
  int? id;
  String? name;
  String? description;

  OrgModel({
    this.id,
    this.name,
    this.description,
  });

  factory OrgModel.fromJson(Map<String, dynamic> json) => OrgModel(
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
