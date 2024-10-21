import 'dart:convert'; // Untuk jsonEncode
import 'package:esas/app/data/auth_user_account_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Storage extends GetxController {
  final GetStorage getstorage = GetStorage();

  // Membuat Rx variabel untuk menyimpan nilai secara reaktif
  var currentToken = ''.obs;
  var currentAccount = AuthUserAccountModel().obs;
  var currentAccountId = 0.obs;

  Storage() {
    currentToken.value = getstorage.read<String>('token') ?? '';
    final accountData = getstorage.read('account');
    if (accountData != null) {
      if (accountData is String) {
        final Map<String, dynamic> accountMap = jsonDecode(accountData);
        currentAccount.value = AuthUserAccountModel.fromJson(accountMap);
        currentAccountId.value = accountMap['id'];
      } else if (accountData is Map<String, dynamic>) {
        currentAccount.value = AuthUserAccountModel.fromJson(accountData);
        currentAccountId.value = accountData['id'];
      }
    }
  }

  // Metode untuk mengupdate token dan memantau secara reaktif
  void updateToken(String token) {
    currentToken.value = token;
    getstorage.write('token', token);
  }

  // Metode untuk mengupdate akun dan memantau secara reaktif
  void updateAccount(Map<String, dynamic> account) {
    currentAccount.value = AuthUserAccountModel.fromJson(account);
    getstorage.write('account', account);
  }

  // Metode untuk menghapus data di penyimpanan
  Future<void> clearStorage() async {
    final keys = ['token', 'ability', 'expired', 'account', 'role'];
    for (var key in keys) {
      if (getstorage.hasData(key)) {
        await getstorage.remove(key);
      }
    }
    currentToken.value = '';
    currentAccountId.value = 0;
    currentAccount.value = AuthUserAccountModel();
  }

  // Metode untuk menyimpan data autentikasi
  Future<void> setStorageAuth(Map<String, dynamic> data) async {
    final token = data['token'];
    final ability = data['abilities'] ?? data['permission'];
    final expiresAt = data['expiresAt'];
    final account = data['account'];
    final role = data['role'];

    // // Menulis data ke storage dengan await
    if (token != null) updateToken(token);
    if (ability != null) await getstorage.write('ability', ability);
    if (expiresAt != null) await getstorage.write('expired', expiresAt);
    if (account != null) updateAccount(account);
    if (role != null) await getstorage.write('role', role);
  }
}
