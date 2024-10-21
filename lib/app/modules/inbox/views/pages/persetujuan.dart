import 'package:esas/app/modules/inbox/controllers/persetujuan_controller.dart';
import 'package:esas/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Persetujuan extends StatelessWidget {
  const Persetujuan({super.key});

  @override
  Widget build(BuildContext context) {
    final PersetujuanController controller = Get.find<PersetujuanController>();
    controller.fetchPengajuan();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const Divider(),
          const SizedBox(height: 20),
          Expanded(
            child: Obx(() => controller.list.isEmpty
                ? _buildEmptyState()
                : NotificationList(controller: controller)),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Permintaan Persetujuan',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Belum ada permintaan persetujuan',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        Text(
          'Permintaan persetujuan Anda akan ditampilkan di sini',
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }
}

class NotificationList extends StatelessWidget {
  final PersetujuanController controller;

  const NotificationList({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollInfo) {
        if (!controller.isLoading &&
            scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          controller.fetchPengajuan();
        }
        return false;
      },
      child: ListView.builder(
        itemCount: controller.list.length,
        itemBuilder: (context, index) {
          if (index == controller.list.length) {
            return const Center(child: Text('Data selesai dimuat'));
          }
          return _buildNotificationItem(controller.list[index]);
        },
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
        leading: const Icon(
          Icons.draw_outlined,
          size: 30,
        ),
        title: Text(limitString(notification.user?.name ?? 'Unknown', 30)),
        subtitle: Text(textString(notification.tablename ?? '')),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 15,
        ),
        onTap: () => _showNotificationDetails(notification),
      ),
    );
  }

  void _showNotificationDetails(notification) {
    Get.bottomSheet(
      Container(
        width: Get.width,
        height: Get.height / 4,
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
              const SizedBox(height: 10),
              Text(
                  'Nama: ${limitString(notification.user?.name ?? 'Unknown', 20)}'),
              Text('Tipe: ${textString(notification.tablename ?? '')}'),
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
