import 'dart:convert';
import 'dart:io';
import 'package:esas/app/models/attendance/detail.dart';
import 'package:esas/app/models/auth/timework.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../base_http_services.dart';

class ApiAbsen extends BaseHttpService {
  final prefix = "/auth";

  Future<dynamic> saveSubmit(Map<String, dynamic> datapost, File file) async {
    http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
      'image',
      file.path,
    );
    return await postFormDataRequest('/attendance', datapost, [multipartFile]);
  }

  Future<List<Detail>> fetchPaginate(int page, int limit, String filter) async {
    final cacheBuster = DateTime.now().millisecondsSinceEpoch;
    final response =
        await getRequest('/attendance/auth?search=$filter&cb=$cacheBuster');
    final data = jsonDecode(response.body)['data'];
    if (kDebugMode) {
      print("=======================>>>>>>>>>>>>>>${data[1]}");
    }
    if (data != null && data.length > 0) {
      return List<Detail>.from(data.map((e) => Detail.fromJson(e)));
    } else {
      return [];
    }
  }

  Future<List<TimeWork>> fetchListTimeAbsen() async {
    final response = await getRequest('$prefix/profile-list-time');
    final data = jsonDecode(response.body)['data'];
    if (kDebugMode) {
      print(data);
    }
    if (data != null && data.length > 0) {
      return List<TimeWork>.from(data.map((e) => TimeWork.fromJson(e)));
    } else {
      return [];
    }
  }

  Future<dynamic> fetchCurrentShift() async {
    return await getRequest('$prefix/profile-schedule');
  }

  Future<dynamic> fetchCurrentAbsen() async {
    final userId = getLocalStorage.read<int>('userId');
    return await getRequest('$prefix/profile-current-attendance/$userId');
  }

  Future<dynamic> fetchLocationAbsen() async {
    return await getRequest('/form$prefix/office');
  }

  Future<dynamic> getRevisionAbsen(String date) async {
    return await getRequest('$prefix/attendance/revision/$date');
  }
}
