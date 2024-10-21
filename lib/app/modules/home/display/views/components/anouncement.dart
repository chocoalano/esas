import 'package:esas/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

import '../../controllers/anouncement_controller.dart';

class Anouncement extends StatelessWidget {
  const Anouncement({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    final AnouncementController controller = Get.put(AnouncementController());
    controller.loadMoreList();

    // Refresh function
    Future<void> onRefresh() async {
      await controller.refreshData();
    }

    // Scroll listener for pagination
    void onScroll() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (controller.hasMore.value) {
          controller.loadMoreList();
        }
      }
    }

    // Add the scroll listener
    scrollController.addListener(onScroll);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleRow(),
          const SizedBox(height: 10),
          Divider(color: Colors.grey.shade300),
          const SizedBox(height: 10),

          // Wrap the content in Flexible or SizedBox to avoid layout issues
          Obx(() {
            if (controller.list.isEmpty) {
              return _buildEmptyAnnouncementMessage();
            } else {
              // Ensure there's a constraint for the ListView
              return RefreshIndicator(
                onRefresh: onRefresh,
                child: SizedBox(
                  height: Get.height / 3.9, // Provide a height constraint
                  child: ListView.builder(
                    itemCount: controller.list.length,
                    itemBuilder: (context, index) {
                      final announcement = controller.list[index];
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: ListTile(
                          title: Text(
                            limitString(announcement.title ?? '', 30),
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black87),
                          ),
                          subtitle: HtmlWidget(
                              limitString(announcement.value ?? '', 30)),
                          trailing: IconButton(
                              onPressed: () => Get.offAllNamed(
                                  '/beranda/anouncement',
                                  arguments: {'id': announcement.id}),
                              icon: const Icon(Icons.chevron_right)),
                        ),
                      );
                    },
                  ),
                ),
              );
            }
          }),
        ],
      ),
    );
  }

  // Helper method for title row
  Row _buildTitleRow() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Pengumuman',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  // Helper method for empty announcement message
  Column _buildEmptyAnnouncementMessage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Belum ada pengumuman',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 8),
        Text(
          'Pengumuman Anda akan ditampilkan di sini',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
        ),
      ],
    );
  }
}
