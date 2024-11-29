// To parse this JSON data, do
//
//     final authUserAccountModel = authUserAccountModelFromJson(jsonString);

import 'dart:convert';

import 'package:esas/app/data/user/address.model.dart';
import 'package:esas/app/data/user/bank_model.dart';
import 'package:esas/app/data/user/bpjs_model.dart';
import 'package:esas/app/data/user/emergency_contact_model.dart';
import 'package:esas/app/data/user/family_model.dart';
import 'package:esas/app/data/user/formal_education_model.dart';
import 'package:esas/app/data/user/informal_education_model.dart';
import 'package:esas/app/data/user/salary_model.dart';
import 'package:esas/app/data/user/tax_config_model.dart';
import 'package:esas/app/data/user/work_experience_model.dart';

import 'user/employe_model.dart';

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
  AddressModel? address;
  BankModel? bank;
  BpjsModel? bpjs;
  List<EmergencyContactModel>? emergencyContact;
  List<FamilyModel>? family;
  List<FormalEducationModel>? formalEducation;
  List<InformalEducationModel>? informalEducation;
  List<WorkExperienceModel>? workExperience;
  SalaryModel? salary;
  TaxConfigModel? taxConfig;
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
        address: json["address"] == null
            ? null
            : AddressModel.fromJson(json["address"]),
        bank: json["bank"] == null ? null : BankModel.fromJson(json["bank"]),
        bpjs: json["bpjs"] == null ? null : BpjsModel.fromJson(json["bpjs"]),
        emergencyContact: json["emergencyContact"] == null
            ? []
            : List<EmergencyContactModel>.from(json["emergencyContact"]!
                .map((x) => EmergencyContactModel.fromJson(x))),
        family: json["family"] == null
            ? []
            : List<FamilyModel>.from(
                json["family"]!.map((x) => FamilyModel.fromJson(x))),
        formalEducation: json["formalEducation"] == null
            ? []
            : List<FormalEducationModel>.from(json["formalEducation"]!
                .map((x) => FormalEducationModel.fromJson(x))),
        informalEducation: json["informalEducation"] == null
            ? []
            : List<InformalEducationModel>.from(json["informalEducation"]!
                .map((x) => InformalEducationModel.fromJson(x))),
        workExperience: json["workExperience"] == null
            ? []
            : List<WorkExperienceModel>.from(json["workExperience"]!
                .map((x) => WorkExperienceModel.fromJson(x))),
        salary: json["salary"] == null
            ? null
            : SalaryModel.fromJson(json["salary"]),
        taxConfig: json["taxConfig"] == null
            ? null
            : TaxConfigModel.fromJson(json["taxConfig"]),
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
