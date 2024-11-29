class FormalEducationModel {
  int? id;
  int? userId;
  String? institution;
  String? majors;
  int? score;
  DateTime? start;
  DateTime? finish;
  String? description;
  int? certification;

  FormalEducationModel({
    this.id,
    this.userId,
    this.institution,
    this.majors,
    this.score,
    this.start,
    this.finish,
    this.description,
    this.certification,
  });

  factory FormalEducationModel.fromJson(Map<String, dynamic> json) =>
      FormalEducationModel(
        id: json["id"] is int ? json["id"] : (json["id"] as double?)?.toInt(),
        userId: json["userId"] is int
            ? json["userId"]
            : (json["userId"] as double?)?.toInt(),
        institution: json["institution"],
        majors: json["majors"],
        score: json["score"] is int
            ? json["score"]
            : (json["score"] as double?)?.toInt(),
        start: json["start"] == null ? null : DateTime.parse(json["start"]),
        finish: json["finish"] == null ? null : DateTime.parse(json["finish"]),
        description: json["description"],
        certification: json["certification"] is int
            ? json["certification"]
            : (json["certification"] as double?)?.toInt(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "institution": institution,
        "majors": majors,
        "score": score,
        "start": start == null
            ? null
            : "${start!.year.toString().padLeft(4, '0')}-${start!.month.toString().padLeft(2, '0')}-${start!.day.toString().padLeft(2, '0')}",
        "finish": finish == null
            ? null
            : "${finish!.year.toString().padLeft(4, '0')}-${finish!.month.toString().padLeft(2, '0')}-${finish!.day.toString().padLeft(2, '0')}",
        "description": description,
        "certification": certification,
      };
}
