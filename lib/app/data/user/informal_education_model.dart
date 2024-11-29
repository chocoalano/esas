class InformalEducationModel {
  int? id;
  int? userId;
  String? name;
  DateTime? start;
  DateTime? finish;
  DateTime? expired;
  String? type;
  int? duration;
  int? fee;
  String? description;
  int? certification;

  InformalEducationModel({
    this.id,
    this.userId,
    this.name,
    this.start,
    this.finish,
    this.expired,
    this.type,
    this.duration,
    this.fee,
    this.description,
    this.certification,
  });

  factory InformalEducationModel.fromJson(Map<String, dynamic> json) =>
      InformalEducationModel(
        id: json["id"],
        userId: json["userId"],
        name: json["name"],
        start: json["start"] == null ? null : DateTime.parse(json["start"]),
        finish: json["finish"] == null ? null : DateTime.parse(json["finish"]),
        expired:
            json["expired"] == null ? null : DateTime.parse(json["expired"]),
        type: json["type"],
        duration: json["duration"],
        fee: json["fee"],
        description: json["description"],
        certification: json["certification"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "name": name,
        "start":
            "${start!.year.toString().padLeft(4, '0')}-${start!.month.toString().padLeft(2, '0')}-${start!.day.toString().padLeft(2, '0')}",
        "finish":
            "${finish!.year.toString().padLeft(4, '0')}-${finish!.month.toString().padLeft(2, '0')}-${finish!.day.toString().padLeft(2, '0')}",
        "expired":
            "${expired!.year.toString().padLeft(4, '0')}-${expired!.month.toString().padLeft(2, '0')}-${expired!.day.toString().padLeft(2, '0')}",
        "type": type,
        "duration": duration,
        "fee": fee,
        "description": description,
        "certification": certification,
      };
}
