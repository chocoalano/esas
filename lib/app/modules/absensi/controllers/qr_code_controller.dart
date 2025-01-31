// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'package:esas/app/modules/absensi/controllers/absensi_controller.dart';
import 'package:esas/app/networks/api/beranda/api_absen.dart';
import 'package:esas/components/widgets/snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class QrCodeController extends GetxController {
  final qrText = ''.obs;
  var isLoading = false.obs;
  final RxMap<String, dynamic> qrData = <String, dynamic>{}.obs;
  final RxMap<String, dynamic> errorMessage = <String, dynamic>{}.obs;
  final AbsensiController absensiC = Get.put(AbsensiController());
  final ApiAbsen provider = Get.put(ApiAbsen());
  QRViewController? qrController;

  void onQRViewCreated(QRViewController controller) {
    qrController = controller;
    qrController!.scannedDataStream.listen((scanData) async {
      final rawText = scanData.code; // Ambil teks dari barcode
      if (rawText == null || rawText.isEmpty) return;

      if (kDebugMode) {
        print("=============== Hasil Scan ====> $rawText");
      }

      // Coba parse JSON jika valid
      try {
        final parsedJson = jsonDecode(rawText);
        qrData.value = parsedJson;
        qrText.value = qrData['token'];
      } catch (e) {
        qrText.value = rawText; // Simpan sebagai teks jika bukan JSON
        qrData.clear();
      }

      qrController?.pauseCamera();

      final datapost = {
        'type': qrData['type'],
        'token': qrData['token'],
      };
      try {
        isLoading(true);
        await provider.submitQRcode(datapost);
        absensiC.fetchCurrentAttendance();
        Get.offAllNamed('/beranda');
        showSuccessSnackbar('Data berhasil disimpan');
      } catch (e) {
        if (kDebugMode) {
          print("============== response error qrcode ${e.toString()}");
        }
        final errorMessage = _extractErrorMessage(e.toString());

        try {
          Map<String, dynamic> jsonResponse = jsonDecode(errorMessage);
          final errorText = jsonResponse['data']?['error'] ??
              "Terjadi kesalahan yang tidak diketahui";

          if (kDebugMode) {
            print("=============== response absen : $jsonResponse");
          }
          showErrorSnackbar("Terjadi kesalahan: $errorText");
        } catch (jsonError) {
          if (kDebugMode) {
            print("Gagal parsing JSON error: $jsonError");
          }
          showErrorSnackbar("Terjadi kesalahan server.");
        }
      } finally {
        isLoading(false);
      }
    });
  }

  String _extractErrorMessage(String exceptionString) {
    try {
      final startIdx = exceptionString.indexOf('{'); // Mulai dari karakter '{'
      if (startIdx == -1) {
        return "{}"; // Jika tidak ditemukan JSON, kembalikan JSON kosong
      }

      final jsonPart = exceptionString.substring(startIdx);
      return jsonPart;
    } catch (e) {
      return "{}"; // Jika gagal, kembalikan JSON kosong
    }
  }

  @override
  void onClose() {
    qrController?.dispose();
    super.onClose();
  }
}
