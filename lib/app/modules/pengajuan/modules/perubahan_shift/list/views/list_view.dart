import 'package:esas/components/floating_action_btn.dart';
import 'package:esas/components/globat_appbar.dart';
import 'package:esas/constant.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/list_controller.dart';

class ListPerubahanShiftView extends GetView<ListController> {
  const ListPerubahanShiftView({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    const currentUserId = 0;

    // Load data after the initial frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadMoreData();
    });

    // Refresh handler
    Future onRefresh() async {
      await controller.refreshData();
    }

    // Scroll listener for infinite scrolling
    void onScroll() {
      double maxScroll = scrollController.position.maxScrollExtent;
      double currentScroll = scrollController.position.pixels;

      if (maxScroll == currentScroll && controller.hasMore.value) {
        controller.loadMoreData();
      }
    }

    // Add scroll listener
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
          title: 'Data perubahan shift',
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
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _buildListItem(
                        context, controller.list[index], currentUserId),
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
          tooltip: 'Ajukan perubahan shift',
          act: () => Get.offAllNamed('/pengajuan/perubahan-shift/form'),
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, var item, int currentUserId) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 209, 209, 209)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              limitString(item.user?.name ?? 'No Name', 20),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            IconButton(
              onPressed: () => _showDetails(item, currentUserId),
              icon: const Icon(Icons.keyboard_arrow_right_sharp),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow('NIK', item.user?.nik ?? 'No NIK'),
            _buildInfoRow(
              'Tgl. Diajukan',
              item.date != null
                  ? DateFormat('yyyy-MM-dd').format(item.date!)
                  : 'No Date Available',
            ),
            _buildInfoRow('Group. Saat ini',
                item.group?.name ?? 'Tidak ada shift diajukan'),
            _buildInfoRow('Shift. Saat ini',
                item.currentshift?.type ?? 'Tidak ada shift diajukan'),
            _buildInfoRow('Shift. Diajukan',
                item.adjustshift?.type ?? 'Tidak ada shift diajukan'),
            const Divider(),
            _buildInfoRowApprove(
                'Approve Line', approvalString(item.lineApprove!)),
            _buildInfoRowApprove('Approve HR', approvalString(item.hrApprove!)),
          ],
        ),
      ),
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
              _buildBottomSheetHeader(),
              const Divider(),
              const SizedBox(height: 10),
              _buildInfoRow('Nama', item.user?.name ?? 'No Name'),
              _buildInfoRow('NIK', item.user?.nik ?? 'No NIK'),
              _buildInfoRow(
                'Tanggal Diajukan',
                item.date != null
                    ? DateFormat('yyyy-MM-dd').format(item.date!)
                    : 'No Date Available',
              ),
              _buildInfoRow('Group. Saat ini',
                  item.group.name ?? 'Tidak ada shift diajukan'),
              _buildInfoRow('Shift. Saat ini',
                  item.currentshift.type ?? 'Tidak ada shift diajukan'),
              _buildInfoRow('Shift. Diajukan',
                  item.adjustshift.type ?? 'Tidak ada shift diajukan'),
              const Divider(),
              _buildInfoRowApprove(
                  'Approve Line', approvalString(item.lineApprove!)),
              _buildInfoRowApprove(
                  'Approve HR', approvalString(item.hrApprove!)),
              const SizedBox(height: 20),

              // Displaying approval buttons
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
                            item.id, 'perubahan-shift', 'n'),
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
                            item.id, 'perubahan-shift', 'y'),
                        child: const Text('Terima',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(value),
      ],
    );
  }

  Widget _buildInfoRowApprove(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(
          value,
          style: TextStyle(
            color: value == 'Disetujui'
                ? primaryColor
                : value == 'Ditolak'
                    ? dangerColor
                    : Colors.brown,
          ),
        ),
      ],
    );
  }
}
