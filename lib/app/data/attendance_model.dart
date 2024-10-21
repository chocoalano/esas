class Attendance {
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
  User? user;

  Attendance({
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

  factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
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
        user: json["user"] != null ? User.fromJson(json["user"]) : null,
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

class User {
  int? id;
  String? name;
  String? nik;
  String? email;
  String? phone;
  String? placebirth;
  DateTime? datebirth;
  String? gender;
  dynamic blood;
  dynamic maritalStatus;
  String? religion;
  dynamic image;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  User({
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
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        nik: json["nik"],
        email: json["email"],
        phone: json["phone"],
        placebirth: json["placebirth"],
        datebirth: json["datebirth"] != null
            ? DateTime.parse(json["datebirth"])
            : null,
        gender: json["gender"],
        blood: json["blood"],
        maritalStatus: json["maritalStatus"],
        religion: json["religion"],
        image: json["image"],
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
        deletedAt: json["deletedAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "nik": nik,
        "email": email,
        "phone": phone,
        "placebirth": placebirth,
        "datebirth": datebirth != null
            ? "${datebirth!.year.toString().padLeft(4, '0')}-${datebirth!.month.toString().padLeft(2, '0')}-${datebirth!.day.toString().padLeft(2, '0')}"
            : null,
        "gender": gender,
        "blood": blood,
        "maritalStatus": maritalStatus,
        "religion": religion,
        "image": image,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
      };
}
