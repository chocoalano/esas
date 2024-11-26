class KoreksiAbsenModel {
  int id;
  int userId;
  DateTime dateAdjustment;
  String timeinAdjustment;
  String timeoutAdjustment;
  String notes;
  String status;
  int lineId;
  String lineApprove;
  int hrId;
  String hrApprove;
  DateTime createdAt;
  DateTime updatedAt;

  KoreksiAbsenModel({
    required this.id,
    required this.userId,
    required this.dateAdjustment,
    required this.timeinAdjustment,
    required this.timeoutAdjustment,
    required this.notes,
    required this.status,
    required this.lineId,
    required this.lineApprove,
    required this.hrId,
    required this.hrApprove,
    required this.createdAt,
    required this.updatedAt,
  });

  factory KoreksiAbsenModel.fromJson(Map<String, dynamic> json) =>
      KoreksiAbsenModel(
        id: json["id"],
        userId: json["userId"],
        dateAdjustment: DateTime.parse(json["dateAdjustment"]),
        timeinAdjustment: json["timeinAdjustment"],
        timeoutAdjustment: json["timeoutAdjustment"],
        notes: json["notes"],
        status: json["status"],
        lineId: json["lineId"],
        lineApprove: json["lineApprove"],
        hrId: json["hrId"],
        hrApprove: json["hrApprove"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "dateAdjustment":
            "${dateAdjustment.year.toString().padLeft(4, '0')}-${dateAdjustment.month.toString().padLeft(2, '0')}-${dateAdjustment.day.toString().padLeft(2, '0')}",
        "timeinAdjustment": timeinAdjustment,
        "timeoutAdjustment": timeoutAdjustment,
        "notes": notes,
        "status": status,
        "lineId": lineId,
        "lineApprove": lineApprove,
        "hrId": hrId,
        "hrApprove": hrApprove,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
