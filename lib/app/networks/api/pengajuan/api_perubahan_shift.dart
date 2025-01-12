import 'dart:convert';
import 'package:esas/app/data/permit/perubahan_shift_model.dart';
import 'package:get/get.dart';
import '../../base_http_services.dart';

class ApiPerubahanShift extends BaseHttpService {
  final prefix = "/mobile";

  Future<List<ListPerubahanShifyModel>> fetchPaginate(
      int page, int limit) async {
    final response = await getRequest(
        '$prefix/perubahan-shift/list?page=$page&limit=$limit');
    final data = jsonDecode(response.body)['data'];
    if (data != null && data.length > 0) {
      return List<ListPerubahanShifyModel>.from(
          data.map((e) => ListPerubahanShifyModel.fromJson(e)));
    } else {
      return [];
    }
  }

  Future<dynamic> fetchSchedule(String date) async {
    const authId = 0;
    return await getRequest(
        '$prefix/perubahan-shift/list?userIdSelected=$authId&date=$date');
  }

  Future<dynamic> fetchApproval(String date) async {
    return await getRequest('$prefix/perubahan-shift/list?date=$date');
  }

  Future<dynamic> fetchPrepared() async {
    final response = await getRequest('$prefix/perubahan-shift/list');
    return response;
  }

  Future<dynamic> submitCreate(Map<String, dynamic> datapost) async {
    return await postRequest('$prefix/perubahan-shift/add', datapost);
  }

  Future<dynamic> approval(int id, String status, String tablename) async {
    return await putRequest(
        '$prefix/notification/approval/$id/$tablename', {'status': status});
  }
}
