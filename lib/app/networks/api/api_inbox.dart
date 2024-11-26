import 'dart:convert';
import 'package:esas/app/data/inbox/notification/notification_model.dart';
import 'package:esas/app/data/inbox/pengajuan/pengajuan_model.dart';
import 'package:flutter/foundation.dart';
import '../base_http_services.dart';

class ApiInbox extends BaseHttpService {
  final prefix = "/mobile";
  Future<List<PengajuanModel>> fetchPaginatePengajuan(
      int page, int limit) async {
    final response = await getRequest(
        '$prefix/notification/list?page=$page&limit=$limit&type=pengajuan');
    final data = jsonDecode(response.body);
    if (kDebugMode) {
      print(data['notifications']);
    }
    if (data['notifications']['data'] != null &&
        data['notifications']['data'].length > 0) {
      return List<PengajuanModel>.from(
          data['notifications']['data'].map((e) => PengajuanModel.fromJson(e)));
    } else {
      return [];
    }
  }

  Future<List<NotificationListModel>> fetchPaginateNotification(
      int page, int limit) async {
    final response = await getRequest(
        '$prefix/notification/list?page=$page&limit=$limit&type=');
    final data = jsonDecode(response.body);
    if (kDebugMode) {
      print(data['notifications']['data']);
    }
    if (data['notifications']['data'] != null &&
        data['notifications']['data'].length > 0) {
      return List<NotificationListModel>.from(data['notifications']['data']
          .map((e) => NotificationListModel.fromJson(e)));
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
