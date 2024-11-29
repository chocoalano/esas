class TaxConfigModel {
  int? id;
  int? userId;
  String? npwp15DigitOld;
  String? npwp16DigitNew;
  String? ptkpStatus;
  String? taxMethod;
  String? taxSalary;
  String? empTaxStatus;
  int? beginningNetto;
  int? pph21Paid;

  TaxConfigModel({
    this.id,
    this.userId,
    this.npwp15DigitOld,
    this.npwp16DigitNew,
    this.ptkpStatus,
    this.taxMethod,
    this.taxSalary,
    this.empTaxStatus,
    this.beginningNetto,
    this.pph21Paid,
  });

  factory TaxConfigModel.fromJson(Map<String, dynamic> json) => TaxConfigModel(
        id: json["id"],
        userId: json["userId"],
        npwp15DigitOld: json["npwp15DigitOld"],
        npwp16DigitNew: json["npwp16DigitNew"],
        ptkpStatus: json["ptkpStatus"],
        taxMethod: json["taxMethod"],
        taxSalary: json["taxSalary"],
        empTaxStatus: json["empTaxStatus"],
        beginningNetto: json["beginningNetto"],
        pph21Paid: json["pph21Paid"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "npwp15DigitOld": npwp15DigitOld,
        "npwp16DigitNew": npwp16DigitNew,
        "ptkpStatus": ptkpStatus,
        "taxMethod": taxMethod,
        "taxSalary": taxSalary,
        "empTaxStatus": empTaxStatus,
        "beginningNetto": beginningNetto,
        "pph21Paid": pph21Paid,
      };
}
