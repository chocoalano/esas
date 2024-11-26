class LemburModel {
  int id;
  int useridCreated;
  DateTime dateSpl;
  int organizationId;
  int jobPositionId;
  int overtimeDayStatus;
  DateTime dateOvertimeAt;
  int userAdm;
  String adminApproved;
  int userLine;
  String lineApproved;
  int userGm;
  String gmApproved;
  int userHr;
  String hrgaApproved;
  int userDirector;
  String directorApproved;
  int userFat;
  String fatApproved;
  DateTime createdAt;
  DateTime updatedAt;

  LemburModel({
    required this.id,
    required this.useridCreated,
    required this.dateSpl,
    required this.organizationId,
    required this.jobPositionId,
    required this.overtimeDayStatus,
    required this.dateOvertimeAt,
    required this.userAdm,
    required this.adminApproved,
    required this.userLine,
    required this.lineApproved,
    required this.userGm,
    required this.gmApproved,
    required this.userHr,
    required this.hrgaApproved,
    required this.userDirector,
    required this.directorApproved,
    required this.userFat,
    required this.fatApproved,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LemburModel.fromJson(Map<String, dynamic> json) => LemburModel(
        id: json["id"],
        useridCreated: json["useridCreated"],
        dateSpl: DateTime.parse(json["dateSpl"]),
        organizationId: json["organizationId"],
        jobPositionId: json["jobPositionId"],
        overtimeDayStatus: json["overtimeDayStatus"],
        dateOvertimeAt: DateTime.parse(json["dateOvertimeAt"]),
        userAdm: json["userAdm"],
        adminApproved: json["adminApproved"],
        userLine: json["userLine"],
        lineApproved: json["lineApproved"],
        userGm: json["userGm"],
        gmApproved: json["gmApproved"],
        userHr: json["userHr"],
        hrgaApproved: json["hrgaApproved"],
        userDirector: json["userDirector"],
        directorApproved: json["directorApproved"],
        userFat: json["userFat"],
        fatApproved: json["fatApproved"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "useridCreated": useridCreated,
        "dateSpl":
            "${dateSpl.year.toString().padLeft(4, '0')}-${dateSpl.month.toString().padLeft(2, '0')}-${dateSpl.day.toString().padLeft(2, '0')}",
        "organizationId": organizationId,
        "jobPositionId": jobPositionId,
        "overtimeDayStatus": overtimeDayStatus,
        "dateOvertimeAt":
            "${dateOvertimeAt.year.toString().padLeft(4, '0')}-${dateOvertimeAt.month.toString().padLeft(2, '0')}-${dateOvertimeAt.day.toString().padLeft(2, '0')}",
        "userAdm": userAdm,
        "adminApproved": adminApproved,
        "userLine": userLine,
        "lineApproved": lineApproved,
        "userGm": userGm,
        "gmApproved": gmApproved,
        "userHr": userHr,
        "hrgaApproved": hrgaApproved,
        "userDirector": userDirector,
        "directorApproved": directorApproved,
        "userFat": userFat,
        "fatApproved": fatApproved,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
