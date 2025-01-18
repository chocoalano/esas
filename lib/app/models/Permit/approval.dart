class Approval {
  int? id;
  int? permitId;
  int? userId;
  String? userType;
  String? userApprove;
  dynamic notes;
  DateTime? createdAt;
  DateTime? updatedAt;

  Approval({
    this.id,
    this.permitId,
    this.userId,
    this.userType,
    this.userApprove,
    this.notes,
    this.createdAt,
    this.updatedAt,
  });

  factory Approval.fromJson(Map<String, dynamic> json) => Approval(
        id: json["id"],
        permitId: json["permit_id"],
        userId: json["user_id"],
        userType: json["user_type"],
        userApprove: json["user_approve"],
        notes: json["notes"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "permit_id": permitId,
        "user_id": userId,
        "user_type": userType,
        "user_approve": userApprove,
        "notes": notes,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
