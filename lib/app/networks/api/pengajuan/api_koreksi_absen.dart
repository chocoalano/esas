import 'dart:convert';
import 'package:esas/app/data/korabs_model.dart';
import 'package:esas/services/storage.dart';
import 'package:get/get.dart';
import '../../base_http_services.dart';

class ApiKoreksiAbsen extends BaseHttpService {
  final Storage storage = Get.find<Storage>();
  final prefix = "/mobile";

  Future<List<KoreksiAbsenModel>> fetchPaginate(int page, int limit) async {
    final response = await getRequest(
        '$prefix/koreksi-absensi/list?page=$page&limit=$limit');
    final data = jsonDecode(response.body)['data'];
    if (data != null && data.length > 0) {
      return List<KoreksiAbsenModel>.from(
          data.map((e) => KoreksiAbsenModel.fromJson(e)));
    } else {
      return [];
    }
  }

  Future<dynamic> fetchSchedule(String date) async {
    final authId = storage.currentAccountId.value;
    return await getRequest(
        '$prefix/koreksi-absensi/list?userIdSelected=$authId&date=$date');
  }

  Future<dynamic> fetchRevision(String date) async {
    final response = await getRequest('$prefix/attendance/revision/$date');
    return response;
  }

  Future<dynamic> fetchApproval() async {
    final userId = storage.currentAccountId.value;
    return await getRequest(
        '$prefix/koreksi-absensi/list?userIdSelected=$userId');
  }

  Future<dynamic> fetchPrepared() async {
    final response = await getRequest('$prefix/koreksi-absensi/list');
    return response;
  }

  Future<dynamic> submitCreate(Map<String, dynamic> datapost) async {
    return await postRequest('$prefix/koreksi-absensi/add', datapost);
  }

  Future<dynamic> approval(int id, String status, String tablename) async {
    return await putRequest(
        '$prefix/notification/approval/$id/$tablename', {'status': status});
  }
}
