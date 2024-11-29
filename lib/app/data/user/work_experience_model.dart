class WorkExperienceModel {
  int? id;
  int? userId;
  String? company;
  String? position;
  DateTime? from;
  DateTime? to;
  String? lengthOfService;

  WorkExperienceModel({
    this.id,
    this.userId,
    this.company,
    this.position,
    this.from,
    this.to,
    this.lengthOfService,
  });

  factory WorkExperienceModel.fromJson(Map<String, dynamic> json) =>
      WorkExperienceModel(
        id: json["id"],
        userId: json["userId"],
        company: json["company"],
        position: json["position"],
        from: json["from"] == null ? null : DateTime.parse(json["from"]),
        to: json["to"] == null ? null : DateTime.parse(json["to"]),
        lengthOfService: json["lengthOfService"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "company": company,
        "position": position,
        "from":
            "${from!.year.toString().padLeft(4, '0')}-${from!.month.toString().padLeft(2, '0')}-${from!.day.toString().padLeft(2, '0')}",
        "to":
            "${to!.year.toString().padLeft(4, '0')}-${to!.month.toString().padLeft(2, '0')}-${to!.day.toString().padLeft(2, '0')}",
        "lengthOfService": lengthOfService,
      };
}
