import 'package:esas/app/models/notification/notification_model.dart';
import 'package:esas/app/modules/inbox/controllers/inbox_controller.dart';
import 'package:esas/components/BottomNavigation/bot_nav_view.dart';
import 'package:esas/components/widgets/build_empty_message.dart';
import 'package:esas/constant.dart';
import 'package:esas/support/support.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class InboxView extends GetView<InboxController> {
  const InboxView({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    // Refresh function
    Future<void> onRefresh() async {
      await controller.refreshData();
    }

    // Scroll listener for pagination
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 100 &&
          controller.hasMore.value &&
          !controller.isLoading.value) {
        controller.loadMoreList();
      }
    });

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
          title: const Text(
            'Inbox',
            style: TextStyle(color: bgColor),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () => controller.refreshData(),
                icon: const Icon(
                  Icons.refresh,
                  color: bgColor,
                )),
            IconButton(
                onPressed: () => controller.clearData(),
                icon: const Icon(
                  Icons.clear,
                  color: bgColor,
                ))
          ],
        ),
        body: RefreshIndicator(
          onRefresh: onRefresh,
          child: Obx(() {
            if (controller.isLoading.isTrue) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            } else {
              if (controller.list.isEmpty) {
                return Center(
                  child: buildEmptyMessage(
                      'Tidak ada data', 'Data akan ditampilkan disini'),
                );
              }
              return ListView.builder(
                controller: scrollController,
                itemCount: controller.list.length + 1,
                itemBuilder: (context, index) {
                  if (index < controller.list.length) {
                    final data = controller.list[index];
                    return _buildListItem(data);
                  } else if (controller.hasMore.value) {
                    return const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    return const SizedBox(); // Tidak ada lebih banyak data
                  }
                },
              );
            }
          }),
        ),
        bottomNavigationBar: BotNavView(),
      ),
    );
  }

  Widget _buildListItem(NotificationModel data) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        color: bgColor,
        child: ListTile(
          leading: data.readAt == null
              ? const Icon(Icons.notifications_active, color: primaryColor)
              : const Icon(Icons.notifications),
          title: Text(
            limitString(data.data!.title ?? '', 30),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
          subtitle: Text(data.data!.body ?? ''),
          onTap: () => controller.read(data.id!),
        ),
      ),
    );
  }
}
