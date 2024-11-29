import 'dart:convert';
import 'package:esas/app/data/org_model.dart';
import 'package:esas/app/data/user/user_model.dart';
import 'package:esas/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:esas/app/networks/api/pengajuan/api_lembur.dart';

class FormController extends GetxController {
  final ApiLembur _provider = ApiLembur();
  var listUser = <UserModel>[].obs;
  var listOrg = <OrgModel>[].obs;
  var listPosition = <OrgModel>[].obs;

  var listAdm = <UserModel>[].obs;
  var listLine = <UserModel>[].obs;
  var listGm = <UserModel>[].obs;
  var listHrd = <UserModel>[].obs;
  var listDirektur = <UserModel>[].obs;
  var listFat = <UserModel>[].obs;
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
    _assignListData<UserModel>('users', data, listUser, UserModel.fromJson);
    _assignListData<OrgModel>('dept', data, listOrg, OrgModel.fromJson);
    _assignListData<OrgModel>('pos', data, listPosition, OrgModel.fromJson);
  }

  void _handleFetchUserChangeOptions(Map<String, dynamic> data) {
    _assignListData<UserModel>('adm', data, listAdm, UserModel.fromJson);
    _assignListData<UserModel>('line', data, listLine, UserModel.fromJson);
    _assignListData<UserModel>('gm', data, listGm, UserModel.fromJson);
    _assignListData<UserModel>('hr', data, listHrd, UserModel.fromJson);
    _assignListData<UserModel>(
        'director', data, listDirektur, UserModel.fromJson);
    _assignListData<UserModel>('fat', data, listFat, UserModel.fromJson);
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
