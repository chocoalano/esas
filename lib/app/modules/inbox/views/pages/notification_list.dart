// ignore_for_file: library_private_types_in_public_api

import 'package:esas/app/modules/inbox/controllers/notification_list_controller.dart';
import 'package:esas/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({super.key});

  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  final NotificationListController controller =
      Get.find<NotificationListController>();
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
        leading: notification.isread == 'n'
            ? const Icon(
                Icons.notifications_active,
                color: primaryColor,
              )
            : const Icon(Icons.notifications),
        title: Text(limitString(notification.fromUser?.name ?? 'Unknown', 20)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(limitString(notification.type ?? 'Unknown', 30)),
            Text(limitString(notification.title ?? 'Unknown', 30)),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 15),
        onTap: () async {
          await controller.isreadInformation(
              notification.id, notification.type);
          controller.list.refresh();
        },
      ),
    );
  }

  Widget buildRowText(String field, String value) {
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
}
