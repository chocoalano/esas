import 'dart:convert';
import 'package:esas/app/models/auth/user_detail.dart';
import 'package:esas/app/modules/login/controllers/login_controller.dart';
import 'package:esas/app/networks/api/akun/api_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController {
  // Dependency injection
  final GetStorage _localStorage = GetStorage();
  final ApiAuth _apiAuthRepository = Get.find<ApiAuth>();
  final LoginController _loginController = Get.find<LoginController>();

  // Observable for user details
  final userDetail = UserDetail(
    id: null,
    companyId: null,
    name: null,
    nip: null,
    email: null,
    emailVerifiedAt: null,
    avatar: null,
    status: null,
    createdAt: null,
    updatedAt: null,
    details: null,
    address: null,
    salaries: null,
    families: null,
    formalEducations: null,
    informalEducations: null,
    workExperiences: null,
    employee: null,
  ).obs;

  // Check authentication and navigate accordingly
  Future<void> checkAuth() async {
    try {
      // Retrieve token from local storage
      final token = _localStorage.read<String>('token');

      // If no token, navigate to login
      if (token == null || token.isEmpty) {
        // Adding delay to avoid navigation conflict
        Future.delayed(Duration.zero, () {
          Get.offAllNamed('/login');
        });
        return;
      }

      // Fetch user profile if token exists
      final response = await _apiAuthRepository.getProfile();
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        userDetail.value = UserDetail.fromJson(data['data']);

        // Adding delay to avoid navigation conflict
        Future.delayed(Duration.zero, () {
          Get.offAllNamed('/beranda');
        });
      } else {
        // Handle unauthorized or failed response
        _handleAuthError();
      }
    } catch (e) {
      // Log error and clear storage if any exception occurs
      if (kDebugMode) {
        print('Error in checkAuth: $e');
      }
      _handleAuthError();
    }
  }

  // Handle authentication error and clear storage
  void _handleAuthError() {
    _loginController.clearStorage();
    // Adding delay to avoid navigation conflict
    Future.delayed(const Duration(minutes: 1), () {
      Get.offAllNamed('/login');
    });
  }
}
