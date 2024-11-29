import 'branch_model.dart';
import 'job_model.dart';
import 'user_model.dart';

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
