// ignore_for_file: library_prefixes

import 'package:esas/constant.dart';
import 'package:esas/services/storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'notif_service.dart';

class NotificationController extends GetxController {
  final NotifService notifService = Get.put(NotifService());
  final Storage storage = Get.put(Storage());
  late IO.Socket socket;

  @override
  void onInit() {
    super.onInit();
    initSocket();
  }

  void initSocket() {
    // Menghubungkan ke server AdonisJS Socket.IO
    socket = IO.io(
      baseUrlApi, // Ganti dengan URL server Anda
      IO.OptionBuilder()
          .setTransports(['websocket']) // Menggunakan websocket transport
          .disableAutoConnect() // Menonaktifkan auto-connect
          .build(),
    );

    // Koneksi ke socket server
    socket.connect();

    // Saat menerima pesan 'userConnected' dari server
    socket.on('connection', (data) {
      _handleNotificationData(data);
    });

    // Anda bisa menambah event lain di sini jika diperlukan
  }

  void _handleNotificationData(dynamic data) {
    if (data is List) {
      for (var item in data) {
        _checkAndShowNotification(item);
      }
    } else if (data is Map<String, dynamic>) {
      _handlePayload(data);
    }
  }

  void _checkAndShowNotification(Map<String, dynamic> item) {
    if (storage.currentAccountId.value == item['to']) {
      notifService.showNotification(item['title'], item['message']);
    }
  }

  void _handlePayload(Map<String, dynamic> data) {
    String title = data['title'];
    String message = data['message'];
    final payload = data['payload'] as Map<String, dynamic>;

    // Menggunakan map untuk menyederhanakan pengecekan role
    final validRoles = {
      'pengajuan-cuti': [payload['userLine'], payload['userHr']],
      'pengajuan-shift': [payload['lineId'], payload['hrId']],
      'pengajuan-lembur': [
        payload['userAdm'],
        payload['userLine'],
        payload['userGm'],
        payload['userHr'],
        payload['userDirector'],
        payload['userFat'],
      ],
      'pengajuan-korbsen': [payload['lineId'], payload['hrId']],
    };

    if (validRoles.containsKey(data['type'])) {
      for (var roleId in validRoles[data['type']]!) {
        if (storage.currentAccountId.value == roleId) {
          notifService.showNotification(title, message);
          break;
        }
      }
    } else if (kDebugMode) {
      print(payload);
    }
  }

  @override
  void onClose() {
    socket.dispose(); // Menutup socket ketika controller dihancurkan
    super.onClose();
  }
}
