import 'package:esas/components/floating_action_btn.dart';
import 'package:esas/components/globat_appbar.dart';
import 'package:esas/constant.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/list_controller.dart';

class ListCutiView extends GetView<ListController> {
  const ListCutiView({super.key});
  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
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

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
        Get.offAllNamed('/pengajuan');
      },
      child: Scaffold(
          backgroundColor: bgColor,
          appBar: GlobatAppbar(
            title: 'Data Cuti',
            act: () => Get.offAllNamed('/pengajuan'),
          ),
          body: RefreshIndicator(
            onRefresh: onRefresh,
            child: Obx(() {
              return ListView.builder(
                controller: scrollController,
                itemCount: controller.hasMore.value
                    ? controller.list.length + 1
                    : controller.list.length,
                itemBuilder: (context, index) {
                  if (index < controller.list.length) {
                    final item = controller.list[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromARGB(255, 209, 209, 209)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(limitString(
                                  item.user!.name ?? 'No Name', 50)),
                              IconButton(
                                  onPressed: () => _showDetails(item, 0),
                                  icon: const Icon(
                                    Icons.info_outline,
                                    color: primaryColor,
                                  ))
                            ],
                          ),
                          subtitle: Column(
                            children: [
                              _buildInfoRow('NIK', item.user?.nik ?? ''),
                              _buildInfoRow('Jenis Cuti', item.type ?? ''),
                              _buildInfoRow('Mulai',
                                  '${formatDate(item.startDate)} | ${item.startTime}'),
                              _buildInfoRow('Sampai',
                                  '${formatDate(item.endDate)} | ${item.endTime}'),
                              const Divider(),
                              _buildInfoRow('Status Line',
                                  approvalString(item.lineApproved ?? 'w')),
                              _buildInfoRow('Status HRGA',
                                  approvalString(item.hrgaApproved ?? 'w')),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return const Padding(
                      padding: EdgeInsets.all(15),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        ),
                      ),
                    );
                  }
                },
              );
            }),
          ),
          floatingActionButton: CustomFloatingActionButton(
            tooltip: 'Ajukan cuti',
            act: () => Get.offAllNamed('/pengajuan/cuti/form'),
          )),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(value),
      ],
    );
  }

  void _showDetails(var item, int currentUserId) {
    Get.bottomSheet(
      Container(
        width: Get.width,
        height: item.userLine == currentUserId || item.userHr == currentUserId
            ? Get.height / 2
            : Get.height / 2.8,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
              ),
              const Divider(),
              const SizedBox(height: 10),
              _buildInfoRow('NIK', item.user?.nik ?? ''),
              _buildInfoRow('Jenis Cuti', item.type ?? ''),
              _buildInfoRow('Kategori Cuti', '${item.category ?? ''} day'),
              _buildInfoRow(
                  'Mulai', '${formatDate(item.startDate)} | ${item.startTime}'),
              _buildInfoRow(
                  'Sampai', '${formatDate(item.endDate)} | ${item.endTime}'),
              _buildInfoRow(
                  'Status Line', approvalString(item.lineApproved ?? 'w')),
              _buildInfoRow(
                  'Status HRGA', approvalString(item.hrgaApproved ?? 'w')),
              const SizedBox(height: 20),
              if (item.userLine == currentUserId && item.lineApproved == 'w' ||
                  item.userHr == currentUserId && item.hrgaApproved == 'w')
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: dangerColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: () =>
                            controller.approval(item.id, 'cuti', 'n'),
                        child: const Text('Tolak',
                            style: TextStyle(color: Colors.white)),
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
                        onPressed: () =>
                            controller.approval(item.id, 'cuti', 'y'),
                        child: const Text('Terima',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }
}
