class CutiModel {
  int id;
  int userId;
  DateTime startDate;
  DateTime endDate;
  String startTime;
  String endTime;
  String category;
  String type;
  String description;
  String userApproved;
  int userLine;
  String lineApproved;
  int userHr;
  String hrgaApproved;
  DateTime createdAt;
  DateTime updatedAt;

  CutiModel({
    required this.id,
    required this.userId,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    required this.category,
    required this.type,
    required this.description,
    required this.userApproved,
    required this.userLine,
    required this.lineApproved,
    required this.userHr,
    required this.hrgaApproved,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CutiModel.fromJson(Map<String, dynamic> json) => CutiModel(
        id: json["id"],
        userId: json["userId"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        startTime: json["startTime"],
        endTime: json["endTime"],
        category: json["category"],
        type: json["type"],
        description: json["description"],
        userApproved: json["userApproved"],
        userLine: json["userLine"],
        lineApproved: json["lineApproved"],
        userHr: json["userHr"],
        hrgaApproved: json["hrgaApproved"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "startDate":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "endDate":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "startTime": startTime,
        "endTime": endTime,
        "category": category,
        "type": type,
        "description": description,
        "userApproved": userApproved,
        "userLine": userLine,
        "lineApproved": lineApproved,
        "userHr": userHr,
        "hrgaApproved": hrgaApproved,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
