import 'dart:convert';
import 'package:esas/constant.dart';
import 'package:get/get.dart';
import 'package:esas/app/modules/pengajuan/modules/lembur/models/list_adm_model.dart';
import 'package:esas/app/modules/pengajuan/modules/lembur/models/list_direktur_model.dart';
import 'package:esas/app/modules/pengajuan/modules/lembur/models/list_fat_model.dart';
import 'package:esas/app/modules/pengajuan/modules/lembur/models/list_gm_model.dart';
import 'package:esas/app/modules/pengajuan/modules/lembur/models/list_hrd_model.dart';
import 'package:esas/app/modules/pengajuan/modules/lembur/models/list_line_model.dart';
import 'package:esas/app/networks/api/pengajuan/api_lembur.dart';
import '../../models/list_org_model.dart';
import '../../models/list_position_model.dart';
import '../../models/list_user_model.dart';

class FormController extends GetxController {
  final ApiLembur _provider = ApiLembur();

  var formList = <Map<String, dynamic>>[].obs;
  var listUser = <ListUserModel>[].obs;
  var listOrg = <ListOrgModel>[].obs;
  var listPosition = <ListPositionModel>[].obs;

  var listAdm = <ListAdmModel>[].obs;
  var listLine = <ListLineModel>[].obs;
  var listGm = <ListGmModel>[].obs;
  var listHrd = <ListHrdModel>[].obs;
  var listDirektur = <ListDirekturModel>[].obs;
  var listFat = <ListFatModel>[].obs;
  var isLoading = false.obs;

  final RxString selectedDate = ''.obs;

  @override
  void onInit() {
    super.onInit();
    addForm();
  }

  void addForm() {
    _fetchFormData();
    formList.add({
      'userIdCreated': 0,
      'organizationId': 0,
      'jobPositionId': 0,
      'overtimeDayStatus': false,
      'dateSpl': formatDate(DateTime.now()),
      'dateOvertimeAt': formatDate(DateTime.now()),
      'userAdm': 0,
      'userLine': 0,
      'userGm': 0,
      'userHr': 0,
      'userDirector': 0,
      'userFat': 0,
    });
  }

  void removeForm(int index) {
    formList.removeAt(index);
  }

  Future<void> _fetchFormData() async {
    isLoading.value = true;
    try {
      final response = await _provider.fetchForms();
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      _handleFetchOptions(data);
    } catch (e) {
      showErrorSnackbar(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchUserData(int userId) async {
    isLoading.value = true;
    try {
      final response = await _provider.fetchUserForms(userId);
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      _handleFetchUserChangeOptions(data);
    } catch (e) {
      showErrorSnackbar(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void _handleFetchOptions(Map<String, dynamic> data) {
    _assignListData<ListUserModel>(
        'users', data, listUser, ListUserModel.fromJson);
    _assignListData<ListOrgModel>('dept', data, listOrg, ListOrgModel.fromJson);
    _assignListData<ListPositionModel>(
        'pos', data, listPosition, ListPositionModel.fromJson);
  }

  void _handleFetchUserChangeOptions(Map<String, dynamic> data) {
    _assignListData<ListAdmModel>('adm', data, listAdm, ListAdmModel.fromJson);
    _assignListData<ListLineModel>(
        'line', data, listLine, ListLineModel.fromJson);
    _assignListData<ListGmModel>('gm', data, listGm, ListGmModel.fromJson);
    _assignListData<ListHrdModel>('hr', data, listHrd, ListHrdModel.fromJson);
    _assignListData<ListDirekturModel>(
        'director', data, listDirektur, ListDirekturModel.fromJson);
    _assignListData<ListFatModel>('fat', data, listFat, ListFatModel.fromJson);
  }

  void _assignListData<T>(String key, Map<String, dynamic> data, RxList<T> list,
      T Function(Map<String, dynamic>) fromJson) {
    if (data.containsKey(key) && data[key] is List) {
      list.assignAll((data[key] as List<dynamic>)
          .map((item) => fromJson(item as Map<String, dynamic>))
          .toList());
    } else {
      showErrorSnackbar('Unexpected format for $key data');
    }
  }

  Future<void> submitForm(int index) async {
    isLoading.value = true;
    try {
      print(formList[index]);
      // await _provider.submitCreate(formList);
      // showSuccessSnackbar('Data berhasil disimpan');
    } catch (e) {
      showErrorSnackbar(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
