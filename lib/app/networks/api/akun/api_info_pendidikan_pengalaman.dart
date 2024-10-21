import '../../base_http_services.dart';

class ApiInfoPendidikanPengalaman extends BaseHttpService {
  Future<dynamic> saveSubmit(
      List<Map<String, dynamic>> datapost, String initial) async {
    if (initial == 'p_formal') {
      final setForm = {'formal_education': datapost};
      return await postRequest('/user-update/pendidikan_formal', setForm);
    } else if (initial == 'p_informal') {
      final setForm = {'informal_education': datapost};
      return await postRequest('/user-update/pendidikan_informal', setForm);
    } else if (initial == 'p_kerja') {
      final setForm = {'work_experiences': datapost};
      return await postRequest('/user-update/pengalaman_kerja', setForm);
    }
  }
}
