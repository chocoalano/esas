// ignore_for_file: library_private_types_in_public_api

import 'package:esas/app/modules/inbox/controllers/persetujuan_controller.dart';
import 'package:esas/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersetujuanList extends StatefulWidget {
  const PersetujuanList({super.key});

  @override
  _PersetujuanListState createState() => _PersetujuanListState();
}

class _PersetujuanListState extends State<PersetujuanList> {
  final PersetujuanController controller = Get.find<PersetujuanController>();
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    controller.loadMoreList();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    await controller.refreshData();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        controller.hasMore.value) {
      controller.loadMoreList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: Obx(
        () => ListView.builder(
          controller: _scrollController,
          itemCount: controller.hasMore.value
              ? controller.list.length + 1
              : controller.list.length,
          itemBuilder: (context, index) {
            if (controller.isLoading.isTrue &&
                index >= controller.list.length) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: CircularProgressIndicator(color: primaryColor),
                ),
              );
            } else if (index < controller.list.length) {
              return _buildNotificationItem(controller.list[index]);
            } else {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Text('Tidak ada data pengajuan saat ini.'),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildNotificationItem(notification) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: const Icon(Icons.draw_outlined, size: 30),
        title: Text(limitString(notification.user?.name ?? 'Unknown', 20)),
        subtitle: Text(textString(notification.tablename ?? '')),
        trailing: const Icon(Icons.arrow_forward_ios, size: 15),
        onTap: () => _showNotificationDetails(notification),
      ),
    );
  }

  void _showNotificationDetails(notification) {
    Get.bottomSheet(
      Container(
        width: Get.width,
        height: Get.height / 2,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBottomSheetHeader(),
              const Divider(),
              const SizedBox(height: 20),
              _buildRowText('Tipe: ', notification.tablename ?? 'Unknown'),
              _buildRowText('Nama: ', notification.user?.name ?? 'Unknown'),
              _buildRowText('NIK: ', notification.user?.nik ?? 'Unknown'),
              _buildRowText(
                  'Tgl. diajukan: ',
                  notification.tablename == 'cuti'
                      ? formatDate(notification.cuti.startDate).toString()
                      : notification.tablename == 'lembur'
                          ? formatDate(notification.lembur.dateSpl).toString()
                          : notification.tablename == 'perubahan-shift'
                              ? formatDate(notification.perubahanShift.date)
                                  .toString()
                              : notification.tablename == 'koreksi-absensi'
                                  ? formatDate(notification
                                          .koreksiAbsen.dateAdjustment)
                                      .toString()
                                  : 'Unknow'),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                padding: const EdgeInsets.all(20),
                child: Text(
                  notification.tablename == 'cuti'
                      ? notification.cuti.description
                      : notification.tablename == 'koreksi-absensi'
                          ? notification.koreksiAbsen.notes
                          : 'Unknow',
                ),
              ),
              const SizedBox(height: 20),
              const Divider(),
              _buildActionButtons(notification),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildBottomSheetHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Detail Permintaan',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.close_outlined),
        ),
      ],
    );
  }

  Widget _buildRowText(String field, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          limitString(field, 10),
          style: const TextStyle(fontWeight: FontWeight.normal),
        ),
        Text(
          limitString(value, 50),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildActionButtons(notification) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: dangerColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onPressed: () => controller.approval(
                notification.id, notification.tablename, 'n'),
            child: const Text('Tolak', style: TextStyle(color: Colors.white)),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onPressed: () => controller.approval(
                notification.id, notification.tablename, 'y'),
            child: const Text('Terima', style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }
}
