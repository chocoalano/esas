class FamilyModel {
  int? id;
  int? userId;
  String? fullname;
  String? relationship;
  DateTime? birthdate;
  String? maritalStatus;
  String? job;

  FamilyModel({
    this.id,
    this.userId,
    this.fullname,
    this.relationship,
    this.birthdate,
    this.maritalStatus,
    this.job,
  });

  factory FamilyModel.fromJson(Map<String, dynamic> json) => FamilyModel(
        id: json["id"],
        userId: json["userId"],
        fullname: json["fullname"],
        relationship: json["relationship"],
        birthdate: json["birthdate"] == null
            ? null
            : DateTime.parse(json["birthdate"]),
        maritalStatus: json["maritalStatus"],
        job: json["job"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "fullname": fullname,
        "relationship": relationship,
        "birthdate":
            "${birthdate!.year.toString().padLeft(4, '0')}-${birthdate!.month.toString().padLeft(2, '0')}-${birthdate!.day.toString().padLeft(2, '0')}",
        "maritalStatus": maritalStatus,
        "job": job,
      };
}
