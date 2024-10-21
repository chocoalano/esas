import 'package:esas/app/data/notification_model.dart';
import 'package:esas/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/data_notification_controller.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    final DataNotificationController controller =
        Get.find<DataNotificationController>();
    controller.fetchPemberitahuan(); // Fetch initial data

    return Column(
      children: [
        _buildInfoSection(),
        const SizedBox(height: 10),
        _buildNotificationList(controller),
      ],
    );
  }

  // Widget untuk bagian informasi di atas
  Widget _buildInfoSection() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.info_outline, color: Colors.green),
              SizedBox(width: 8),
              Text(
                "Ketersediaan data",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            "Anda hanya dapat mengakses data dari 2 tahun terakhir. Untuk mengakses data yang lebih lama, silahkan hubungi kami melalui email.",
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              // Handle "Hubungi kami" action
            },
            child: const Text(
              "Hubungi kami",
              style: TextStyle(color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk bagian list notifikasi
  Widget _buildNotificationList(DataNotificationController controller) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        padding: const EdgeInsets.all(20),
        child: Obx(() {
          // Jika list kosong, tampilkan placeholder
          if (controller.list.isEmpty && !controller.isLoading) {
            return _buildEmptyNotificationPlaceholder();
          }

          // Jika list ada isinya, tampilkan NotificationList
          return NotificationList(controller: controller);
        }),
      ),
    );
  }

  // Widget untuk placeholder ketika tidak ada data notifikasi
  Widget _buildEmptyNotificationPlaceholder() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Pemberitahuan',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const Divider(),
        const SizedBox(height: 20),
        const Text(
          'Belum ada pengumuman',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        Text(
          'Pengumuman Anda akan ditampilkan di sini',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
        ),
      ],
    );
  }
}

class NotificationList extends StatelessWidget {
  final DataNotificationController controller;

  const NotificationList({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (!controller.isLoading &&
            scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
            controller.hasMore.value) {
          controller
              .fetchPemberitahuan(); // Fetch data tambahan saat mencapai bawah
        }
        return false;
      },
      child: ListView.builder(
        itemCount: controller.list.length +
            1, // +1 untuk menampilkan indikator akhir data
        itemBuilder: (context, index) {
          if (index == controller.list.length) {
            return controller.hasMore.value
                ? const Center(child: CircularProgressIndicator())
                : const Center(child: Text('Data selesai dimuat'));
          }

          final notification = controller.list[index];
          return _buildNotificationItem(notification, controller);
        },
      ),
    );
  }

  // Widget untuk item notifikasi
  Widget _buildNotificationItem(
      NotificationModel notification, DataNotificationController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade300, // Warna border
          width: 1.0, // Ketebalan border
        ),
        borderRadius: BorderRadius.circular(10), // Radius sudut border
      ),
      child: ListTile(
        leading: Icon(
          notification.isRead == 'n'
              ? Icons.notification_important_outlined
              : Icons.notifications,
          size: 30,
          color: notification.isRead == 'n' ? primaryColor : Colors.black87,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notification.isRead == 'n' ? 'Baru' : 'Sudah dilihat',
              style: TextStyle(
                color: notification.isRead == 'n' ? primaryColor : Colors.grey,
                fontSize: 10,
              ),
            ),
            Text(limitString(notification.title, 30)),
          ],
        ),
        subtitle: Text(textString(notification.message ?? '')),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 15,
        ),
        onTap: () async {
          await controller.isreadInformation(
              notification.id, notification.type);
          controller.list.refresh(); // Refresh UI setelah status diubah
        },
      ),
    );
  }
}
