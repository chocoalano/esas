// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

List<UserModel> userModelFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Employe {
  int? id;
  int? userId;
  int? organizationId;
  int? jobPositionId;
  int? jobLevelId;
  int? approvalLine;
  int? approvalManager;
  int? companyId;
  int? branchId;
  String? status;
  DateTime? joinDate;
  dynamic signDate;
  Job? org;
  Job? job;
  Job? lvl;
  UserModel? appline;
  UserModel? appmngr;
  Branch? company;
  Branch? branch;

  Employe({
    this.id,
    this.userId,
    this.organizationId,
    this.jobPositionId,
    this.jobLevelId,
    this.approvalLine,
    this.approvalManager,
    this.companyId,
    this.branchId,
    this.status,
    this.joinDate,
    this.signDate,
    this.org,
    this.job,
    this.lvl,
    this.appline,
    this.appmngr,
    this.company,
    this.branch,
  });

  factory Employe.fromJson(Map<String, dynamic> json) => Employe(
        id: json["id"],
        userId: json["userId"],
        organizationId: json["organizationId"],
        jobPositionId: json["jobPositionId"],
        jobLevelId: json["jobLevelId"],
        approvalLine: json["approvalLine"],
        approvalManager: json["approvalManager"],
        companyId: json["companyId"],
        branchId: json["branchId"],
        status: json["status"],
        joinDate:
            json["joinDate"] == null ? null : DateTime.parse(json["joinDate"]),
        signDate: json["signDate"],
        org: json["org"] == null ? null : Job.fromJson(json["org"]),
        job: json["job"] == null ? null : Job.fromJson(json["job"]),
        lvl: json["lvl"] == null ? null : Job.fromJson(json["lvl"]),
        appline: json["appline"] == null
            ? null
            : UserModel.fromJson(json["appline"]),
        appmngr: json["appmngr"] == null
            ? null
            : UserModel.fromJson(json["appmngr"]),
        company:
            json["company"] == null ? null : Branch.fromJson(json["company"]),
        branch: json["branch"] == null ? null : Branch.fromJson(json["branch"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "organizationId": organizationId,
        "jobPositionId": jobPositionId,
        "jobLevelId": jobLevelId,
        "approvalLine": approvalLine,
        "approvalManager": approvalManager,
        "companyId": companyId,
        "branchId": branchId,
        "status": status,
        "joinDate":
            "${joinDate!.year.toString().padLeft(4, '0')}-${joinDate!.month.toString().padLeft(2, '0')}-${joinDate!.day.toString().padLeft(2, '0')}",
        "signDate": signDate,
        "org": org?.toJson(),
        "job": job?.toJson(),
        "lvl": lvl?.toJson(),
        "appline": appline?.toJson(),
        "appmngr": appmngr?.toJson(),
        "company": company?.toJson(),
        "branch": branch?.toJson(),
      };
}

class UserModel {
  int? id;
  String? name;
  String? nik;
  String? email;
  String? phone;
  String? placebirth;
  DateTime? datebirth;
  String? gender;
  String? blood;
  String? maritalStatus;
  String? religion;
  String? image;
  Address? address;
  Employe? employe;

  UserModel({
    this.id,
    this.name,
    this.nik,
    this.email,
    this.phone,
    this.placebirth,
    this.datebirth,
    this.gender,
    this.blood,
    this.maritalStatus,
    this.religion,
    this.image,
    this.address,
    this.employe,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        nik: json["nik"],
        email: json["email"],
        phone: json["phone"],
        placebirth: json["placebirth"],
        datebirth: json["datebirth"] == null
            ? null
            : DateTime.parse(json["datebirth"]),
        gender: json["gender"],
        blood: json["blood"],
        maritalStatus: json["maritalStatus"],
        religion: json["religion"],
        image: json["image"],
        address:
            json["address"] == null ? null : Address.fromJson(json["address"]),
        employe:
            json["employe"] == null ? null : Employe.fromJson(json["employe"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "nik": nik,
        "email": email,
        "phone": phone,
        "placebirth": placebirth,
        "datebirth":
            "${datebirth!.year.toString().padLeft(4, '0')}-${datebirth!.month.toString().padLeft(2, '0')}-${datebirth!.day.toString().padLeft(2, '0')}",
        "gender": gender,
        "blood": blood,
        "maritalStatus": maritalStatus,
        "religion": religion,
        "image": image,
        "address": address?.toJson(),
        "employe": employe?.toJson(),
      };
}

class Branch {
  int? id;
  String? name;
  String? latitude;
  String? longitude;
  String? fullAddress;

  Branch({
    this.id,
    this.name,
    this.latitude,
    this.longitude,
    this.fullAddress,
  });

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        id: json["id"],
        name: json["name"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        fullAddress: json["fullAddress"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "latitude": latitude,
        "longitude": longitude,
        "fullAddress": fullAddress,
      };
}

class Job {
  int? id;
  String? name;
  String? description;

  Job({
    this.id,
    this.name,
    this.description,
  });

  factory Job.fromJson(Map<String, dynamic> json) => Job(
        id: json["id"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
      };
}

class Address {
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

  Address({
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

  factory Address.fromJson(Map<String, dynamic> json) => Address(
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
