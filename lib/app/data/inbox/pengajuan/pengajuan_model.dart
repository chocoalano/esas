// To parse this JSON data, do
//
//     final pengajuanModel = pengajuanModelFromJson(jsonString);

import 'dart:convert';

import '../cuti_model.dart';
import '../koreksi_absen_model.dart';
import '../lembur_model.dart';
import '../perubahan_shift_model.dart';
import '../user_model.dart';

List<PengajuanModel> pengajuanModelFromJson(String str) =>
    List<PengajuanModel>.from(
        json.decode(str).map((x) => PengajuanModel.fromJson(x)));

String pengajuanModelToJson(List<PengajuanModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PengajuanModel {
  String tablename;
  int id;
  int? userCreated;
  int user1;
  int user2;
  dynamic user3;
  dynamic user4;
  dynamic user5;
  dynamic user6;
  String status1;
  String status2;
  dynamic status3;
  dynamic status4;
  dynamic status5;
  dynamic status6;
  UserModel? user;
  CutiModel? cuti;
  PerubahanShiftModel? perubahanShift;
  LemburModel? lembur;
  KoreksiAbsenModel? koreksiAbsen;

  PengajuanModel({
    required this.tablename,
    required this.id,
    required this.userCreated,
    required this.user1,
    required this.user2,
    required this.user3,
    required this.user4,
    required this.user5,
    required this.user6,
    required this.status1,
    required this.status2,
    required this.status3,
    required this.status4,
    required this.status5,
    required this.status6,
    required this.user,
    required this.cuti,
    required this.perubahanShift,
    required this.lembur,
    required this.koreksiAbsen,
  });

  factory PengajuanModel.fromJson(Map<String, dynamic> json) => PengajuanModel(
        tablename: json["tablename"],
        id: json["id"],
        userCreated: json["userCreated"],
        user1: json["user1"],
        user2: json["user2"],
        user3: json["user3"],
        user4: json["user4"],
        user5: json["user5"],
        user6: json["user6"],
        status1: json["status1"],
        status2: json["status2"],
        status3: json["status3"],
        status4: json["status4"],
        status5: json["status5"],
        status6: json["status6"],
        user: json["user"] != null ? UserModel.fromJson(json["user"]) : null,
        cuti: json["cuti"] != null ? CutiModel.fromJson(json["cuti"]) : null,
        perubahanShift: json["perubahanShift"] != null
            ? PerubahanShiftModel.fromJson(json["perubahanShift"])
            : null,
        lembur: json["lembur"] != null
            ? LemburModel.fromJson(json["lembur"])
            : null,
        koreksiAbsen: json["koreksiAbsen"] != null
            ? KoreksiAbsenModel.fromJson(json["koreksiAbsen"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "tablename": tablename,
        "id": id,
        "userCreated": userCreated,
        "user1": user1,
        "user2": user2,
        "user3": user3,
        "user4": user4,
        "user5": user5,
        "user6": user6,
        "status1": status1,
        "status2": status2,
        "status3": status3,
        "status4": status4,
        "status5": status5,
        "status6": status6,
        "user": user?.toJson(),
        "cuti": cuti?.toJson(),
        "perubahanShift": perubahanShift?.toJson(),
        "lembur": lembur?.toJson(),
        "koreksiAbsen": koreksiAbsen?.toJson(),
      };
}
