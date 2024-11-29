import 'package:esas/app/data/user/user_model.dart';

class AttendanceModel {
  int? id;
  String? nik;
  int? scheduleGroupAttendancesId;
  DateTime? date;
  double? latIn;
  double? lngIn;
  String? timeIn;
  dynamic photoIn;
  String? statusIn;
  double? latOut;
  double? lngOut;
  String? timeOut;
  dynamic photoOut;
  String? statusOut;
  DateTime? createdAt;
  DateTime? updatedAt;
  UserModel? user;

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
    this.user,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) =>
      AttendanceModel(
        id: json["id"],
        nik: json["nik"],
        scheduleGroupAttendancesId: json["scheduleGroupAttendancesId"],
        date: json["date"] != null ? DateTime.parse(json["date"]) : null,
        latIn: json["latIn"]?.toDouble(),
        lngIn: json["lngIn"]?.toDouble(),
        timeIn: json["timeIn"],
        photoIn: json["photoIn"],
        statusIn: json["statusIn"], // Mengambil statusIn sebagai string
        latOut: json["latOut"]?.toDouble(),
        lngOut: json["lngOut"]?.toDouble(),
        timeOut: json["timeOut"],
        photoOut: json["photoOut"],
        statusOut: json["statusOut"], // Mengambil statusOut sebagai string
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
        user: json["user"] != null ? UserModel.fromJson(json["user"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nik": nik,
        "scheduleGroupAttendancesId": scheduleGroupAttendancesId,
        "date": date != null
            ? "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}"
            : null,
        "latIn": latIn,
        "lngIn": lngIn,
        "timeIn": timeIn,
        "photoIn": photoIn,
        "statusIn": statusIn, // Menggunakan string
        "latOut": latOut,
        "lngOut": lngOut,
        "timeOut": timeOut,
        "photoOut": photoOut,
        "statusOut": statusOut, // Menggunakan string
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "user": user?.toJson(),
      };
}
