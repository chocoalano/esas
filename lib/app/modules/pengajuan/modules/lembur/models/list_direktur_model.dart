// ignore_for_file: constant_identifier_names

import 'dart:convert';

// Fungsi untuk decode JSON menjadi ListDirekturModel
List<ListDirekturModel> listDirekturModelFromJson(String str) =>
    List<ListDirekturModel>.from(
        json.decode(str).map((x) => ListDirekturModel.fromJson(x)));

// Fungsi untuk encode ListDirekturModel menjadi JSON
String listDirekturModelToJson(List<ListDirekturModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListDirekturModel {
  int? id;
  String? name;
  String? nik;
  String? email;
  String? phone;
  String? placebirth;
  DateTime? datebirth;
  Gender? gender;
  String? blood;
  String? maritalStatus;
  Religion? religion;
  String? image;

  // Constructor
  ListDirekturModel({
    this.id,
    this.name,
    this.nik,
    this.email,
    this.phone,
    this.placebirth,
    this.datebirth,
    this.gender,
    this.blood,
    this.maritalStatus,
    this.religion,
    this.image,
  });

  // Factory method untuk deserialisasi JSON ke ListDirekturModel
  factory ListDirekturModel.fromJson(Map<String, dynamic> json) =>
      ListDirekturModel(
        id: json["id"],
        name: json["name"],
        nik: json["nik"],
        email: json["email"],
        phone: json["phone"],
        placebirth: json["placebirth"],
        datebirth: json["datebirth"] == null
            ? null
            : DateTime.parse(json["datebirth"]),
        gender:
            json["gender"] == null ? null : genderValues.map[json["gender"]],
        blood: json["blood"],
        maritalStatus: json["maritalStatus"],
        religion: json["religion"] == null
            ? null
            : religionValues.map[json["religion"]],
        image: json["image"],
      );

  // Method untuk serialisasi ListDirekturModel ke JSON
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "nik": nik,
        "email": email,
        "phone": phone,
        "placebirth": placebirth,
        "datebirth": datebirth == null
            ? null
            : "${datebirth!.year.toString().padLeft(4, '0')}-${datebirth!.month.toString().padLeft(2, '0')}-${datebirth!.day.toString().padLeft(2, '0')}",
        "gender": gender == null ? null : genderValues.reverse[gender],
        "blood": blood,
        "maritalStatus": maritalStatus,
        "religion": religion == null ? null : religionValues.reverse[religion],
        "image": image,
      };
}

// Enum untuk Gender
enum Gender { M, W }

// Mapping nilai Gender ke string
final genderValues = EnumValues({"m": Gender.M, "w": Gender.W});

// Enum untuk Religion
enum Religion { CATHOLIC, ISLAM, PROTESTANT, HINDU, BUDDHA, KHONGHUCU }

// Mapping nilai Religion ke string
final religionValues = EnumValues({
  "islam": Religion.ISLAM,
  "protestant": Religion.PROTESTANT,
  "catholic": Religion.CATHOLIC,
  "hindu": Religion.HINDU,
  "buddha": Religion.BUDDHA,
  "khonghucu": Religion.KHONGHUCU
});

// Class EnumValues untuk menangani mapping enum ke string
class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  // Getter untuk mendapatkan reverse map
  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
