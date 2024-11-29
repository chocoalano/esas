import 'dart:convert';
import 'package:esas/app/data/list_cuti_model.dart';
import '../../base_http_services.dart';

class ApiCuti extends BaseHttpService {
  final prefix = "/mobile";
  Future<List<ListCutiModel>> fetchPaginate(int page, int limit) async {
    final response =
        await getRequest('$prefix/cuti/list?page=$page&limit=$limit');
    final data = jsonDecode(response.body)['data'];
    if (data != null && data.length > 0) {
      return List<ListCutiModel>.from(
          data.map((e) => ListCutiModel.fromJson(e)));
    } else {
      return [];
    }
  }

  Future<dynamic> fetchApproval(int userId) async {
    return await getRequest('$prefix/cuti/list?userIdSelected=$userId');
  }

  Future<dynamic> submitCreate(Map<String, dynamic> datapost) async {
    return await postRequest('$prefix/cuti/add', datapost);
  }

  Future<dynamic> approval(int id, String status, String tablename) async {
    return await putRequest(
        '$prefix/notification/approval/$id/$tablename', {'status': status});
  }
}
