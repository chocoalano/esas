class SalaryModel {
  int? id;
  int? userId;
  int? basicSalary;
  String? salaryType;
  String? paymentSchedule;
  String? prorateSettings;
  String? overtimeSettings;
  String? costCenter;
  String? costCenterCategory;
  String? currency;

  SalaryModel({
    this.id,
    this.userId,
    this.basicSalary,
    this.salaryType,
    this.paymentSchedule,
    this.prorateSettings,
    this.overtimeSettings,
    this.costCenter,
    this.costCenterCategory,
    this.currency,
  });

  factory SalaryModel.fromJson(Map<String, dynamic> json) => SalaryModel(
        id: json["id"],
        userId: json["userId"],
        basicSalary: json["basicSalary"],
        salaryType: json["salaryType"],
        paymentSchedule: json["paymentSchedule"],
        prorateSettings: json["prorateSettings"],
        overtimeSettings: json["overtimeSettings"],
        costCenter: json["costCenter"],
        costCenterCategory: json["costCenterCategory"],
        currency: json["currency"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "basicSalary": basicSalary,
        "salaryType": salaryType,
        "paymentSchedule": paymentSchedule,
        "prorateSettings": prorateSettings,
        "overtimeSettings": overtimeSettings,
        "costCenter": costCenter,
        "costCenterCategory": costCenterCategory,
        "currency": currency,
      };
}
