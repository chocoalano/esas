import 'package:esas/app/modules/absensi/controllers/qr_code_controller.dart';
import 'package:esas/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class QrCodeScreen extends GetView<QrCodeController> {
  const QrCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop) {
            return;
          }
          Get.offAllNamed('/beranda');
        },
        child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () => controller.qrController?.resumeCamera(),
                  icon: const Icon(
                    Icons.refresh,
                    color: bgColor,
                  ))
            ],
            backgroundColor: primaryColor,
            title: const Text(
              'Scan absensi kode QR',
              style: TextStyle(color: bgColor),
            ),
            leading: IconButton(
                onPressed: () => Get.offAllNamed('/beranda'),
                icon: const Icon(
                  Icons.chevron_left,
                  color: bgColor,
                )),
          ),
          body: Column(
            children: [
              Expanded(
                flex: 5,
                child: QRView(
                  key: GlobalKey(debugLabel: 'QR'),
                  onQRViewCreated: controller.onQRViewCreated,
                  overlay: QrScannerOverlayShape(
                    borderColor: primaryColor,
                    borderRadius: 10,
                    borderLength: 30,
                    borderWidth: 10,
                    cutOutSize: 250,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
