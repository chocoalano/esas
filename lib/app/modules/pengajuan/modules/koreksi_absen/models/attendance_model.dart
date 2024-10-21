// To parse this JSON data, do
//
//     final attendanceModel = attendanceModelFromJson(jsonString);

import 'dart:convert';

AttendanceModel attendanceModelFromJson(String str) =>
    AttendanceModel.fromJson(json.decode(str));

String attendanceModelToJson(AttendanceModel data) =>
    json.encode(data.toJson());

class AttendanceModel {
  int? id;
  String? nik;
  int? scheduleGroupAttendancesId;
  DateTime? date;
  double? latIn;
  double? lngIn;
  String? timeIn;
  String? photoIn;
  String? statusIn;
  dynamic latOut;
  dynamic lngOut;
  dynamic timeOut;
  dynamic photoOut;
  dynamic statusOut;
  DateTime? createdAt;
  DateTime? updatedAt;

  AttendanceModel({
    this.id,
    this.nik,
    this.scheduleGroupAttendancesId,
    this.date,
    this.latIn,
    this.lngIn,
    this.timeIn,
    this.photoIn,
    this.statusIn,
    this.latOut,
    this.lngOut,
    this.timeOut,
    this.photoOut,
    this.statusOut,
    this.createdAt,
    this.updatedAt,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) =>
      AttendanceModel(
        id: json["id"],
        nik: json["nik"],
        scheduleGroupAttendancesId: json["scheduleGroupAttendancesId"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        latIn: json["latIn"]?.toDouble(),
        lngIn: json["lngIn"]?.toDouble(),
        timeIn: json["timeIn"],
        photoIn: json["photoIn"],
        statusIn: json["statusIn"],
        latOut: json["latOut"],
        lngOut: json["lngOut"],
        timeOut: json["timeOut"],
        photoOut: json["photoOut"],
        statusOut: json["statusOut"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nik": nik,
        "scheduleGroupAttendancesId": scheduleGroupAttendancesId,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "latIn": latIn,
        "lngIn": lngIn,
        "timeIn": timeIn,
        "photoIn": photoIn,
        "statusIn": statusIn,
        "latOut": latOut,
        "lngOut": lngOut,
        "timeOut": timeOut,
        "photoOut": photoOut,
        "statusOut": statusOut,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
