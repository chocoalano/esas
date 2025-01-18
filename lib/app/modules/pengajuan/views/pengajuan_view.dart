import 'package:esas/components/BottomNavigation/bot_nav_view.dart';
import 'package:esas/components/widgets/build_empty_message.dart';
import 'package:esas/constant.dart';
import 'package:esas/support/support.dart';
import 'package:esas/support/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../controllers/pengajuan_controller.dart';

class PengajuanView extends GetView<PengajuanController> {
  const PengajuanView({super.key});
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
        if (context.mounted) {
          // Tampilkan dialog konfirmasi keluar (opsional)
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: primaryColor,
          title: Text(
            'Pengajuan',
            style: appbarTitle,
          ),
          centerTitle: true,
        ),
        body: Obx(() {
          if (controller.list.isEmpty) {
            return Center(
              child: buildEmptyMessage(
                  'Tidak ada data', 'Data tim akan ditampilkan disini'),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(15),
            child: ListView.builder(
              itemCount: controller.list.length + 1,
              itemBuilder: (context, index) {
                if (index < controller.list.length) {
                  final data = controller.list[index];
                  return buildPengajuanOption(context,
                      icon: Icons.document_scanner_outlined,
                      text: data.type ?? '',
                      onTap: () =>
                          Get.offAllNamed('pengajuan/cuti', arguments: data));
                } else {
                  return const SizedBox(); // Tidak ada lebih banyak data
                }
              },
            ),
          );
        }),
        bottomNavigationBar: BotNavView(),
      ),
    );
  }

  Widget buildPengajuanOption(BuildContext context,
      {required IconData icon, required String text, VoidCallback? onTap}) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      elevation: 0,
      child: ListTile(
        leading: Icon(icon, color: Colors.black54),
        title:
            Text(capitalizedString(text), style: const TextStyle(fontSize: 16)),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
