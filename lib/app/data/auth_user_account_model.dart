// To parse this JSON data, do
//
//     final authUserAccountModel = authUserAccountModelFromJson(jsonString);

import 'dart:convert';

AuthUserAccountModel authUserAccountModelFromJson(String str) =>
    AuthUserAccountModel.fromJson(json.decode(str));

String authUserAccountModelToJson(AuthUserAccountModel data) =>
    json.encode(data.toJson());

class AuthUserAccountModel {
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
  Bank? bank;
  Bpjs? bpjs;
  List<EmergencyContact>? emergencyContact;
  List<Family>? family;
  List<FormalEducation>? formalEducation;
  List<InformalEducation>? informalEducation;
  List<WorkExperience>? workExperience;
  Salary? salary;
  TaxConfig? taxConfig;
  Employe? employe;

  AuthUserAccountModel({
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
    this.bank,
    this.bpjs,
    this.emergencyContact,
    this.family,
    this.formalEducation,
    this.informalEducation,
    this.workExperience,
    this.salary,
    this.taxConfig,
    this.employe,
  });

  factory AuthUserAccountModel.fromJson(Map<String, dynamic> json) =>
      AuthUserAccountModel(
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
        bank: json["bank"] == null ? null : Bank.fromJson(json["bank"]),
        bpjs: json["bpjs"] == null ? null : Bpjs.fromJson(json["bpjs"]),
        emergencyContact: json["emergencyContact"] == null
            ? []
            : List<EmergencyContact>.from(json["emergencyContact"]!
                .map((x) => EmergencyContact.fromJson(x))),
        family: json["family"] == null
            ? []
            : List<Family>.from(json["family"]!.map((x) => Family.fromJson(x))),
        formalEducation: json["formalEducation"] == null
            ? []
            : List<FormalEducation>.from(json["formalEducation"]!
                .map((x) => FormalEducation.fromJson(x))),
        informalEducation: json["informalEducation"] == null
            ? []
            : List<InformalEducation>.from(json["informalEducation"]!
                .map((x) => InformalEducation.fromJson(x))),
        workExperience: json["workExperience"] == null
            ? []
            : List<WorkExperience>.from(
                json["workExperience"]!.map((x) => WorkExperience.fromJson(x))),
        salary: json["salary"] == null ? null : Salary.fromJson(json["salary"]),
        taxConfig: json["taxConfig"] == null
            ? null
            : TaxConfig.fromJson(json["taxConfig"]),
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
        "bank": bank?.toJson(),
        "bpjs": bpjs?.toJson(),
        "emergencyContact": emergencyContact == null
            ? []
            : List<dynamic>.from(emergencyContact!.map((x) => x.toJson())),
        "family": family == null
            ? []
            : List<dynamic>.from(family!.map((x) => x.toJson())),
        "formalEducation": formalEducation == null
            ? []
            : List<dynamic>.from(formalEducation!.map((x) => x.toJson())),
        "informalEducation": informalEducation == null
            ? []
            : List<dynamic>.from(informalEducation!.map((x) => x.toJson())),
        "workExperience": workExperience == null
            ? []
            : List<dynamic>.from(workExperience!.map((x) => x.toJson())),
        "salary": salary?.toJson(),
        "taxConfig": taxConfig?.toJson(),
        "employe": employe?.toJson(),
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

class Bank {
  int? id;
  int? userId;
  String? bankName;
  String? bankAccount;
  String? bankAccountHolder;

  Bank({
    this.id,
    this.userId,
    this.bankName,
    this.bankAccount,
    this.bankAccountHolder,
  });

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
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

class Bpjs {
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

  Bpjs({
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

  factory Bpjs.fromJson(Map<String, dynamic> json) => Bpjs(
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

class EmergencyContact {
  int? id;
  int? userId;
  String? name;
  String? relationship;
  String? phone;
  String? profesion;

  EmergencyContact({
    this.id,
    this.userId,
    this.name,
    this.relationship,
    this.phone,
    this.profesion,
  });

  factory EmergencyContact.fromJson(Map<String, dynamic> json) =>
      EmergencyContact(
        id: json["id"],
        userId: json["userId"],
        name: json["name"],
        relationship: json["relationship"],
        phone: json["phone"],
        profesion: json["profesion"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "name": name,
        "relationship": relationship,
        "phone": phone,
        "profesion": profesion,
      };
}

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
  dynamic joinDate;
  dynamic signDate;
  Job? org;
  Job? job;
  Job? lvl;
  App? appline;
  App? appmngr;
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
        joinDate: json["joinDate"],
        signDate: json["signDate"],
        org: json["org"] == null ? null : Job.fromJson(json["org"]),
        job: json["job"] == null ? null : Job.fromJson(json["job"]),
        lvl: json["lvl"] == null ? null : Job.fromJson(json["lvl"]),
        appline: json["appline"] == null ? null : App.fromJson(json["appline"]),
        appmngr: json["appmngr"] == null ? null : App.fromJson(json["appmngr"]),
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
        "joinDate": joinDate,
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

class App {
  int? id;
  String? name;
  dynamic nik;
  String? email;
  dynamic phone;
  dynamic placebirth;
  dynamic datebirth;
  dynamic gender;
  dynamic blood;
  dynamic maritalStatus;
  dynamic religion;
  dynamic image;

  App({
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
  });

  factory App.fromJson(Map<String, dynamic> json) => App(
        id: json["id"],
        name: json["name"],
        nik: json["nik"],
        email: json["email"],
        phone: json["phone"],
        placebirth: json["placebirth"],
        datebirth: json["datebirth"],
        gender: json["gender"],
        blood: json["blood"],
        maritalStatus: json["maritalStatus"],
        religion: json["religion"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "nik": nik,
        "email": email,
        "phone": phone,
        "placebirth": placebirth,
        "datebirth": datebirth,
        "gender": gender,
        "blood": blood,
        "maritalStatus": maritalStatus,
        "religion": religion,
        "image": image,
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

class Family {
  int? id;
  int? userId;
  String? fullname;
  String? relationship;
  DateTime? birthdate;
  String? maritalStatus;
  String? job;

  Family({
    this.id,
    this.userId,
    this.fullname,
    this.relationship,
    this.birthdate,
    this.maritalStatus,
    this.job,
  });

  factory Family.fromJson(Map<String, dynamic> json) => Family(
        id: json["id"],
        userId: json["userId"],
        fullname: json["fullname"],
        relationship: json["relationship"],
        birthdate: json["birthdate"] == null
            ? null
            : DateTime.parse(json["birthdate"]),
        maritalStatus: json["maritalStatus"],
        job: json["job"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "fullname": fullname,
        "relationship": relationship,
        "birthdate":
            "${birthdate!.year.toString().padLeft(4, '0')}-${birthdate!.month.toString().padLeft(2, '0')}-${birthdate!.day.toString().padLeft(2, '0')}",
        "maritalStatus": maritalStatus,
        "job": job,
      };
}

class FormalEducation {
  int? id;
  int? userId;
  String? institution;
  String? majors;
  int? score;
  DateTime? start;
  DateTime? finish;
  String? description;
  int? certification;

  FormalEducation({
    this.id,
    this.userId,
    this.institution,
    this.majors,
    this.score,
    this.start,
    this.finish,
    this.description,
    this.certification,
  });

  factory FormalEducation.fromJson(Map<String, dynamic> json) =>
      FormalEducation(
        id: json["id"],
        userId: json["userId"],
        institution: json["institution"],
        majors: json["majors"],
        score: json["score"],
        start: json["start"] == null ? null : DateTime.parse(json["start"]),
        finish: json["finish"] == null ? null : DateTime.parse(json["finish"]),
        description: json["description"],
        certification: json["certification"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "institution": institution,
        "majors": majors,
        "score": score,
        "start":
            "${start!.year.toString().padLeft(4, '0')}-${start!.month.toString().padLeft(2, '0')}-${start!.day.toString().padLeft(2, '0')}",
        "finish":
            "${finish!.year.toString().padLeft(4, '0')}-${finish!.month.toString().padLeft(2, '0')}-${finish!.day.toString().padLeft(2, '0')}",
        "description": description,
        "certification": certification,
      };
}

class InformalEducation {
  int? id;
  int? userId;
  String? name;
  DateTime? start;
  DateTime? finish;
  DateTime? expired;
  String? type;
  int? duration;
  int? fee;
  String? description;
  int? certification;

  InformalEducation({
    this.id,
    this.userId,
    this.name,
    this.start,
    this.finish,
    this.expired,
    this.type,
    this.duration,
    this.fee,
    this.description,
    this.certification,
  });

  factory InformalEducation.fromJson(Map<String, dynamic> json) =>
      InformalEducation(
        id: json["id"],
        userId: json["userId"],
        name: json["name"],
        start: json["start"] == null ? null : DateTime.parse(json["start"]),
        finish: json["finish"] == null ? null : DateTime.parse(json["finish"]),
        expired:
            json["expired"] == null ? null : DateTime.parse(json["expired"]),
        type: json["type"],
        duration: json["duration"],
        fee: json["fee"],
        description: json["description"],
        certification: json["certification"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "name": name,
        "start":
            "${start!.year.toString().padLeft(4, '0')}-${start!.month.toString().padLeft(2, '0')}-${start!.day.toString().padLeft(2, '0')}",
        "finish":
            "${finish!.year.toString().padLeft(4, '0')}-${finish!.month.toString().padLeft(2, '0')}-${finish!.day.toString().padLeft(2, '0')}",
        "expired":
            "${expired!.year.toString().padLeft(4, '0')}-${expired!.month.toString().padLeft(2, '0')}-${expired!.day.toString().padLeft(2, '0')}",
        "type": type,
        "duration": duration,
        "fee": fee,
        "description": description,
        "certification": certification,
      };
}

class Salary {
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

  Salary({
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

  factory Salary.fromJson(Map<String, dynamic> json) => Salary(
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

class TaxConfig {
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

  TaxConfig({
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

  factory TaxConfig.fromJson(Map<String, dynamic> json) => TaxConfig(
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

class WorkExperience {
  int? id;
  int? userId;
  String? company;
  String? position;
  DateTime? from;
  DateTime? to;
  String? lengthOfService;

  WorkExperience({
    this.id,
    this.userId,
    this.company,
    this.position,
    this.from,
    this.to,
    this.lengthOfService,
  });

  factory WorkExperience.fromJson(Map<String, dynamic> json) => WorkExperience(
        id: json["id"],
        userId: json["userId"],
        company: json["company"],
        position: json["position"],
        from: json["from"] == null ? null : DateTime.parse(json["from"]),
        to: json["to"] == null ? null : DateTime.parse(json["to"]),
        lengthOfService: json["lengthOfService"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "company": company,
        "position": position,
        "from":
            "${from!.year.toString().padLeft(4, '0')}-${from!.month.toString().padLeft(2, '0')}-${from!.day.toString().padLeft(2, '0')}",
        "to":
            "${to!.year.toString().padLeft(4, '0')}-${to!.month.toString().padLeft(2, '0')}-${to!.day.toString().padLeft(2, '0')}",
        "lengthOfService": lengthOfService,
      };
}
