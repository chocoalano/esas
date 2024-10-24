import 'dart:convert';
import 'package:esas/constant.dart';
import 'package:flutter/material.dart';
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

  // Observables untuk data form
  late final TextEditingController userIdCreated;
  late final TextEditingController organizationId;
  late final TextEditingController jobPositionId;
  late final TextEditingController overtimeDayStatus;
  late final TextEditingController dateSpl;

  late final TextEditingController dateOvertimeAt;
  late final TextEditingController userAdm;
  late final TextEditingController userLine;
  late final TextEditingController userGm;
  late final TextEditingController userHr;
  late final TextEditingController userDirector;
  late final TextEditingController userFat;

  @override
  void onInit() {
    super.onInit();
    _fetchFormData();
    dateOvertimeAt = TextEditingController();
    userAdm = TextEditingController();
    userLine = TextEditingController();
    userGm = TextEditingController();
    userHr = TextEditingController();
    userDirector = TextEditingController();
    userFat = TextEditingController();
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

  Future<void> fetchUserData() async {
    isLoading.value = true;
    try {
      final response = await _provider.fetchUserForms();
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

  Future<void> submitForm() async {
    isLoading.value = true;
    try {
      Map<String, dynamic> formObj = {
        'dateOvertimeAt': dateOvertimeAt.text,
        'userAdm': userAdm.text,
        'userLine': userLine.text,
        'userGm': userGm.text,
        'userHr': userHr.text,
        'userDirector': userDirector.text,
        'userFat': userFat.text,
      };
      await _provider.submitCreate(formObj);
      showSuccessSnackbar('Data berhasil disimpan');
      Get.toNamed('pengajuan/lembur/list');
    } catch (e) {
      showErrorSnackbar(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
