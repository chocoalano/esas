class BankModel {
  int? id;
  int? userId;
  String? bankName;
  String? bankAccount;
  String? bankAccountHolder;

  BankModel({
    this.id,
    this.userId,
    this.bankName,
    this.bankAccount,
    this.bankAccountHolder,
  });

  factory BankModel.fromJson(Map<String, dynamic> json) => BankModel(
        id: json["id"],
        userId: json["userId"],
        bankName: json["bankName"],
        bankAccount: json["bankAccount"],
        bankAccountHolder: json["bankAccountHolder"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "bankName": bankName,
        "bankAccount": bankAccount,
        "bankAccountHolder": bankAccountHolder,
      };
}
