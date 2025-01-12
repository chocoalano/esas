import 'dart:convert';
import 'dart:io';
import 'package:esas/app/models/attendance/detail.dart';
import 'package:http/http.dart' as http;
import '../../base_http_services.dart';

class ApiAbsen extends BaseHttpService {
  final prefix = "/auth";
  Future<dynamic> saveSubmit(Map<String, dynamic> datapost, File file) async {
    http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
      'photo',
      file.path,
    );
    return await postFormDataRequest(
        '$prefix/attendance/add', datapost, [multipartFile]);
  }

  Future<dynamic> fetchTime() async {
    return await getRequest('/web/time-all');
  }

  Future<List<Detail>> fetchPaginate(int page, int limit, String filter) async {
    final response = await getRequest('/attendance/auth?search=$filter');
    final data = jsonDecode(response.body)['data'];
    if (data != null && data.length > 0) {
      return List<Detail>.from(data.map((e) => Detail.fromJson(e)));
    } else {
      return [];
    }
  }

  Future<dynamic> fetchCurrentShift() async {
    return await getRequest('$prefix/profile-schedule');
  }

  Future<dynamic> fetchCurrentAbsen() async {
    return await getRequest('$prefix/attendance/current-date');
  }

  Future<dynamic> fetchLocationAbsen() async {
    return await getRequest('/form$prefix/office');
  }

  Future<dynamic> getRevisionAbsen(String date) async {
    return await getRequest('$prefix/attendance/revision/$date');
  }
}
