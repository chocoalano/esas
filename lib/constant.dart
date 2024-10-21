import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// const baseUrlApi = 'https://api.sinergiabadisentosa.com';
// const baseUrlImg = 'https://api.sinergiabadisentosa.com/files';
const baseUrlApi = 'http://172.16.0.117:3333';
const baseUrlImg = 'http://172.16.0.117:3333/files';

const primaryColor = Color(0xFF079246);
const secondaryColor = Color(0xFF92C13F);
const warningColor = Color(0xFFF6E005);
const dangerColor = Color(0xFFA02334);
const infoColor = Colors.blue;
const bgColor = Colors.white;

const defaultPadding = 16.0;

Future<bool?> showBackDialog() {
  return Get.dialog<bool>(
    AlertDialog(
      title: const Text('Apakah kamu yakin?'),
      content: const Text(
        'Apakah Anda yakin ingin meninggalkan halaman ini?',
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Get.back(result: false);
          },
          child: const Text(
            'Tidak, tetap disini.',
            style: TextStyle(color: dangerColor),
          ),
        ),
        TextButton(
          onPressed: () {
            Get.back(result: true);
          },
          child: const Text('Ya, Tinggalkan',
              style: TextStyle(color: primaryColor)),
        ),
      ],
    ),
  );
}

showErrorSnackbar(String message) {
  Get.snackbar(
    'Error',
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.red,
    colorText: Colors.white,
    duration: const Duration(seconds: 3),
  );
}

showWarningSnackbar(String message) {
  Get.snackbar(
    'Warning',
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: warningColor,
    colorText: Colors.white,
    duration: const Duration(seconds: 3),
  );
}

showSuccessSnackbar(String message) {
  Get.snackbar(
    'Success',
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: primaryColor,
    colorText: Colors.white,
    duration: const Duration(seconds: 3),
  );
}

String limitString(String text, int maxLength) {
  if (text.isEmpty) return text;
  String limitedText =
      text.length <= maxLength ? text : '${text.substring(0, maxLength)}...';
  return limitedText[0].toUpperCase() + limitedText.substring(1).toLowerCase();
}

String textString(String type) {
  switch (type) {
    case 'cuti':
      return 'Pengajuan permohonan permintaan cuti';
    case 'koreksi-absensi':
      return 'Pengajuan permohonan permintaan koreksi absensi';
    case 'lembur':
      return 'Pengajuan permohonan permintaan lembur';
    case 'perubahan-shift':
      return 'Pengajuan permohonan permintaan perubahan jadwal/shift';
    default:
      return 'Pengajuan permohonan permintaan yang belum diketahui';
  }
}

String approvalString(String type) {
  switch (type) {
    case 'w':
      return 'Menunggu';
    case 'y':
      return 'Disetujui';
    case 'n':
      return 'Ditolak';
    default:
      return '';
  }
}

double safeToDouble(dynamic value) {
  if (value == null) {
    return 0.0;
  }
  if (value is double) {
    return value;
  }
  if (value is int) {
    return value.toDouble();
  }
  try {
    return double.parse(value.toString());
  } catch (e) {
    return 0.0;
  }
}

String formatDate(DateTime? date) {
  if (date == null) return ''; // Handle null date case
  return DateFormat('yyyy-MM-dd').format(date);
}

// Format TimeOfDay to HH:mm:ss string
String formatTime(TimeOfDay time) {
  final now = DateTime.now();
  final formattedTime =
      DateTime(now.year, now.month, now.day, time.hour, time.minute);
  return DateFormat('HH:mm:ss').format(formattedTime);
}

String formatTimeSting(String? time) {
  if (time == null || time.isEmpty) {
    return '00:00'; // Mengembalikan nilai default jika null atau kosong
  }
  final parts = time.split(':');
  if (parts.length >= 2) {
    final hour =
        parts[0].padLeft(2, '0'); // Menambahkan '0' jika jam kurang dari 10
    final minute =
        parts[1].padLeft(2, '0'); // Menambahkan '0' jika menit kurang dari 10
    return '$hour:$minute'; // Mengembalikan waktu dalam format HH:mm
  }
  return '00:00';
}

Widget buildInfoRowApprove(String label, String value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      Text(
        value,
        style: TextStyle(
          color: value == 'Disetujui'
              ? primaryColor
              : value == 'Ditolak'
                  ? dangerColor
                  : Colors.brown,
        ),
      ),
    ],
  );
}
