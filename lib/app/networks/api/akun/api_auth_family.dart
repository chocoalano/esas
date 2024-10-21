import 'package:esas/app/networks/base_http_services.dart';

class ApiAuthFamily extends BaseHttpService {
  Future<dynamic> saveSubmit(List<Map<String, dynamic>> datapost) async {
    final setForm = {'families': datapost};
    return await postRequest('/user-update/kontak_keluarga', setForm);
  }
}
