import 'package:esas/components/floating_action_btn.dart';
import 'package:esas/components/globat_appbar.dart';
import 'package:esas/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/list_controller.dart';

class ListKoreksiAbsenView extends GetView<ListController> {
  const ListKoreksiAbsenView({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    const currentUserId = 0;
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
            title: 'Koreksi Absen',
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
                              Text(item.user!.name ?? 'No Name'),
                              IconButton(
                                  onPressed: () =>
                                      _showDetails(item, currentUserId),
                                  icon: const Icon(
                                    Icons.info_outline,
                                    color: primaryColor,
                                  ))
                            ],
                          ),
                          subtitle: Column(
                            children: [
                              _buildInfoRow('NIK', item.user?.nik ?? 'No NIK'),
                              _buildInfoRow(
                                'Tgl. Diajukan',
                                item.dateAdjustment != null
                                    ? formatDate(item.dateAdjustment)
                                    : 'No Date Available',
                              ),
                              _buildInfoRow(
                                  'Wkt-in. Diajukan',
                                  item.timeinAdjustment ??
                                      'Tidak ada jam diajukan'),
                              _buildInfoRow(
                                  'Wkt-out. Diajukan',
                                  item.timeoutAdjustment ??
                                      'Tidak ada jam diajukan'),
                              const Divider(),
                              buildInfoRowApprove('Approve Line',
                                  approvalString(item.lineApprove!)),
                              buildInfoRowApprove('Approve HR',
                                  approvalString(item.hrApprove!)),
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
            tooltip: 'Ajukan lembur',
            act: () => Get.offAllNamed('/pengajuan/koreksi-absen/form'),
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
        height: item.lineId == currentUserId || item.hrId == currentUserId
            ? Get.height / 2
            : Get.height / 2.5,
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
              _buildInfoRow('Nama', item.user?.name ?? 'No Name'),
              _buildInfoRow('NIK', item.user?.nik ?? 'No NIK'),
              _buildInfoRow(
                'Tanggal Diajukan',
                item.dateAdjustment != null
                    ? formatDate(item.dateAdjustment!)
                    : 'No Date Available',
              ),
              _buildInfoRow('Wkt-in Diajukan',
                  item.timeinAdjustment ?? 'Tidak ada jam diajukan'),
              _buildInfoRow('Wkt-out Diajukan',
                  item.timeoutAdjustment ?? 'Tidak ada jam diajukan'),
              buildInfoRowApprove(
                  'Approve Line', approvalString(item.lineApprove!)),
              buildInfoRowApprove(
                  'Approve HR', approvalString(item.hrApprove!)),
              const SizedBox(height: 20),
              if (item.lineId == currentUserId && item.lineApprove == 'w' ||
                  item.hrId == currentUserId && item.hrApprove == 'w')
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
                        onPressed: () => controller.approval(
                            item.id, 'koreksi-absensi', 'n'),
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
                        onPressed: () => controller.approval(
                            item.id, 'koreksi-absensi', 'y'),
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
    );
  }
}
