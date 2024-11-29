class AddressModel {
  int? id;
  int? userId;
  String? idtype;
  String? idnumber;
  dynamic idexpired;
  int? ispermanent;
  String? postalcode;
  String? citizenIdAddress;
  int? useAsResidential;
  String? residentialAddress;

  AddressModel({
    this.id,
    this.userId,
    this.idtype,
    this.idnumber,
    this.idexpired,
    this.ispermanent,
    this.postalcode,
    this.citizenIdAddress,
    this.useAsResidential,
    this.residentialAddress,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        id: json["id"],
        userId: json["userId"],
        idtype: json["idtype"],
        idnumber: json["idnumber"],
        idexpired: json["idexpired"],
        ispermanent: json["ispermanent"],
        postalcode: json["postalcode"],
        citizenIdAddress: json["citizenIdAddress"],
        useAsResidential: json["useAsResidential"],
        residentialAddress: json["residentialAddress"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "idtype": idtype,
        "idnumber": idnumber,
        "idexpired": idexpired,
        "ispermanent": ispermanent,
        "postalcode": postalcode,
        "citizenIdAddress": citizenIdAddress,
        "useAsResidential": useAsResidential,
        "residentialAddress": residentialAddress,
      };
}
