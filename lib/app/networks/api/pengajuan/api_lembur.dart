import 'dart:convert';
import 'package:esas/app/data/lembur_model.dart';
import 'package:esas/services/storage.dart';
import 'package:get/get.dart';
import '../../base_http_services.dart';

class ApiLembur extends BaseHttpService {
  final Storage storage = Get.find<Storage>();
  final prefix = "/mobile";

  Future<List<LemburModel>> fetchPaginate(int page, int limit) async {
    final response =
        await getRequest('$prefix/lembur/list?page=$page&limit=$limit');
    final data = jsonDecode(response.body)['list']['data'];
    if (data != null && data.length > 0) {
      return List<LemburModel>.from(data.map((e) => LemburModel.fromJson(e)));
    } else {
      return [];
    }
  }

  Future<dynamic> fetchForms() async {
    return await getRequest('$prefix/lembur/list');
  }

  Future<dynamic> fetchUserForms() async {
    return await getRequest('$prefix/lembur/list?userId=0');
  }

  Future<dynamic> fetchApproval(String date) async {
    return await getRequest('$prefix/lembur/list?date=$date');
  }

  Future<dynamic> submitCreate(Map<String, dynamic> dataPost) async {
    return await postRequest('$prefix/lembur/add', dataPost);
  }

  Future<dynamic> approval(int id, String status, String tableName) async {
    return await putRequest(
        '$prefix/notification/approval/$id/$tableName', {'status': status});
  }
}
