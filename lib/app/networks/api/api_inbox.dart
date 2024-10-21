import 'dart:convert';
import 'package:esas/app/data/notification_model.dart';
import 'package:esas/app/data/pengajuan_model.dart';
import '../base_http_services.dart';

class ApiInbox extends BaseHttpService {
  final prefix = "/mobile";
  Future<List<PengajuanModel>> fetchPaginatePengajuan(
      int page, int limit) async {
    final response = await getRequest(
        '$prefix/notification/list?page=$page&limit=$limit&type=pengajuan');
    final data = jsonDecode(response.body);
    if (data['data'] != null && data['data'].length > 0) {
      return List<PengajuanModel>.from(
          data['data'].map((e) => PengajuanModel.fromJson(e)));
    } else {
      return [];
    }
  }

  Future<List<NotificationModel>> fetchPaginateNotification(
      int page, int limit) async {
    final response = await getRequest(
        '$prefix/notification/list?page=$page&limit=$limit&type=');
    final data = jsonDecode(response.body);
    if (data['data'] != null && data['data'].length > 0) {
      return List<NotificationModel>.from(data['notifications']['data']
          .map((e) => NotificationModel.fromJson(e)));
    } else {
      return [];
    }
  }

  Future<dynamic> isreadNotificationAction(int id) async {
    return await getRequest('$prefix/notification/show/$id');
  }

  Future<dynamic> approval(int id, String status, String tablename) async {
    final Map<String, dynamic> datapost = {'status': status};
    return await putRequest(
        '$prefix/notification/approval/$id/$tablename', datapost);
  }
}
