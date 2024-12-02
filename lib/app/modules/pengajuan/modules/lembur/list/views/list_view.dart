import 'package:esas/components/floating_action_btn.dart';
import 'package:esas/components/globat_appbar.dart';
import 'package:esas/constant.dart';
import 'package:esas/services/storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/list_controller.dart';

class ListLemburView extends GetView<ListController> {
  const ListLemburView({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    final Storage storage = Storage();
    final currentUserId = storage.currentAccountId.value;
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
            title: 'Data Pengajuan Lembur',
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
                              Text(item.user?.name ?? 'No Name'),
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
                              _buildInfoRow('NIK', item.user?.nik ?? ''),
                              _buildInfoRow('Departemen', item.org?.name ?? ''),
                              _buildInfoRow(
                                  'Jabatan', item.position?.name ?? ''),
                              _buildInfoRow('Tgl. Lembur Diajukan',
                                  item.dateOvertimeAt.toString()),
                              const Divider(),
                              buildInfoRowApprove('Status Admin',
                                  approvalString(item.adminApproved ?? 'w')),
                              buildInfoRowApprove('Status Line',
                                  approvalString(item.lineApproved ?? 'w')),
                              buildInfoRowApprove('Status GM',
                                  approvalString(item.gmApproved ?? 'w')),
                              buildInfoRowApprove('Status HRGA',
                                  approvalString(item.hrgaApproved ?? 'w')),
                              buildInfoRowApprove('Status Direktur',
                                  approvalString(item.directorApproved ?? 'w')),
                              buildInfoRowApprove('Status FAT',
                                  approvalString(item.fatApproved ?? 'w')),
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
            act: () => Get.offAllNamed('/pengajuan/lembur/form'),
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
        height: item.userAdm == currentUserId ||
                item.userLine == currentUserId ||
                item.userGm == currentUserId ||
                item.userHr == currentUserId ||
                item.userDirector == currentUserId ||
                item.userFat == currentUserId
            ? Get.height / 2
            : Get.height / 2.3,
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
              _buildInfoRow('Departemen', item.org?.name ?? ''),
              _buildInfoRow('Jabatan', item.position?.name ?? ''),
              _buildInfoRow(
                  'Tgl. Lembur Diajukan', item.dateOvertimeAt.toString()),
              buildInfoRowApprove(
                  'Status Admin', approvalString(item.adminApproved ?? 'w')),
              buildInfoRowApprove(
                  'Status Line', approvalString(item.lineApproved ?? 'w')),
              buildInfoRowApprove(
                  'Status GM', approvalString(item.gmApproved ?? 'w')),
              buildInfoRowApprove(
                  'Status HRGA', approvalString(item.hrgaApproved ?? 'w')),
              buildInfoRowApprove('Status Direktur',
                  approvalString(item.directorApproved ?? 'w')),
              buildInfoRowApprove(
                  'Status FAT', approvalString(item.fatApproved ?? 'w')),
              const SizedBox(height: 20),
              if (item.userAdm == currentUserId && item.adminApproved == 'w' ||
                  item.userLine == currentUserId && item.lineApproved == 'w' ||
                  item.userGm == currentUserId && item.gmApproved == 'w' ||
                  item.userHr == currentUserId && item.hrgaApproved == 'w' ||
                  item.userDirector == currentUserId &&
                      item.directorApproved == 'w' ||
                  item.userFat == currentUserId && item.fatApproved == 'w')
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
      isScrollControlled: true,
    );
  }
}
