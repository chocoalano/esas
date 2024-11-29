class BpjsModel {
  int? id;
  int? userId;
  dynamic bpjsKetenagakerjaan;
  dynamic nppBpjsKetenagakerjaan;
  dynamic bpjsKetenagakerjaanDate;
  String? bpjsKesehatan;
  String? bpjsKesehatanFamily;
  dynamic bpjsKesehatanDate;
  int? bpjsKesehatanCost;
  dynamic jhtCost;
  String? jaminanPensiunCost;
  dynamic jaminanPensiunDate;

  BpjsModel({
    this.id,
    this.userId,
    this.bpjsKetenagakerjaan,
    this.nppBpjsKetenagakerjaan,
    this.bpjsKetenagakerjaanDate,
    this.bpjsKesehatan,
    this.bpjsKesehatanFamily,
    this.bpjsKesehatanDate,
    this.bpjsKesehatanCost,
    this.jhtCost,
    this.jaminanPensiunCost,
    this.jaminanPensiunDate,
  });

  factory BpjsModel.fromJson(Map<String, dynamic> json) => BpjsModel(
        id: json["id"],
        userId: json["userId"],
        bpjsKetenagakerjaan: json["bpjsKetenagakerjaan"],
        nppBpjsKetenagakerjaan: json["nppBpjsKetenagakerjaan"],
        bpjsKetenagakerjaanDate: json["bpjsKetenagakerjaanDate"],
        bpjsKesehatan: json["bpjsKesehatan"],
        bpjsKesehatanFamily: json["bpjsKesehatanFamily"],
        bpjsKesehatanDate: json["bpjsKesehatanDate"],
        bpjsKesehatanCost: json["bpjsKesehatanCost"],
        jhtCost: json["jhtCost"],
        jaminanPensiunCost: json["jaminanPensiunCost"],
        jaminanPensiunDate: json["jaminanPensiunDate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "bpjsKetenagakerjaan": bpjsKetenagakerjaan,
        "nppBpjsKetenagakerjaan": nppBpjsKetenagakerjaan,
        "bpjsKetenagakerjaanDate": bpjsKetenagakerjaanDate,
        "bpjsKesehatan": bpjsKesehatan,
        "bpjsKesehatanFamily": bpjsKesehatanFamily,
        "bpjsKesehatanDate": bpjsKesehatanDate,
        "bpjsKesehatanCost": bpjsKesehatanCost,
        "jhtCost": jhtCost,
        "jaminanPensiunCost": jaminanPensiunCost,
        "jaminanPensiunDate": jaminanPensiunDate,
      };
}
