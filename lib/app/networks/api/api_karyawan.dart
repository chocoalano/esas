import 'dart:convert';
import 'package:esas/app/data/user_model.dart';
import '../base_http_services.dart';

class ApiKaryawan extends BaseHttpService {
  final prefix = "/mobile";
  Future<List<UserModel>> fetchList(String search) async {
    final response = await getRequest('$prefix/users?search=$search');
    final data = jsonDecode(response.body);
    if (data != null && data.length > 0) {
      return List<UserModel>.from(data.map((e) => UserModel.fromJson(e)));
    } else {
      return [];
    }
  }
}
