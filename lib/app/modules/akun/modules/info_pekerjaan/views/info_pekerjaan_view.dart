import 'package:esas/components/globat_appbar.dart';
import 'package:esas/constant.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/info_pekerjaan_controller.dart';

class InfoPekerjaanView extends GetView<InfoPekerjaanController> {
  const InfoPekerjaanView({super.key});
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
        Get.offAllNamed('/akun');
      },
      child: Scaffold(
        appBar: GlobatAppbar(
          title: 'Info pekerjaan',
          act: () => Get.offAllNamed('/akun'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_buildAttendanceInfo(controller)],
          ),
        ),
      ),
    );
  }

  Widget _buildAttendanceInfo(InfoPekerjaanController controller) {
    return Obx(() {
      final data = controller.accountModel.value;
      if (controller.isloading.isFalse) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Data pekerjaan',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black54),
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 10,
                  ),
                  _buildInfoRow('NIP', data.account!.nik!),
                  _buildInfoRow('Nama', data.account!.name!),
                  _buildInfoRow('email', data.account!.email!),
                  _buildInfoRow(
                      'Kantor', data.account!.employe!.company!.name!),
                  _buildInfoRow('Cabang', data.account!.employe!.branch!.name!),
                  _buildInfoRow(
                      'Departemen', data.account!.employe!.org!.name!),
                  _buildInfoRow('Jabatan', data.account!.employe!.job!.name!),
                  _buildInfoRow('Level', data.account!.employe!.lvl!.name!),
                  _buildInfoRow(
                      'Approval line', data.account!.employe!.appline!.name!),
                  _buildInfoRow('Approval manager',
                      data.account!.employe!.appmngr!.name!),
                ],
              ),
            ),
          ],
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(
            color: primaryColor,
          ),
        );
      }
    });
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: _labelStyle()),
          const SizedBox(width: 8),
          Text(value),
        ],
      ),
    );
  }

  TextStyle _labelStyle() {
    return TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.grey[600],
    );
  }
}
