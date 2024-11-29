class TimeModel {
  int? id;
  String? type;
  String? timeIn;
  String? out;
  String? patternName;
  dynamic rules;

  TimeModel({
    this.id,
    this.type,
    this.timeIn,
    this.out,
    this.patternName,
    this.rules,
  });

  factory TimeModel.fromJson(Map<String, dynamic> json) => TimeModel(
        id: json["id"],
        type: json["type"],
        timeIn: json["in"],
        out: json["out"],
        patternName: json["patternName"],
        rules: json["rules"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "in": timeIn,
        "out": out,
        "patternName": patternName,
        "rules": rules,
      };
}
