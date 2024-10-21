import 'package:esas/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/list_controller.dart';

class AbsensiView extends StatelessWidget {
  const AbsensiView({super.key});

  @override
  Widget build(BuildContext context) {
    final ListController controller = Get.put(ListController());
    final ScrollController scrollController = ScrollController();

    // Load data saat widget diinisialisasi
    controller.loadMoreList();

    // Mengatur penanganan refresh
    Future<void> onRefresh() async {
      await controller.refreshData();
    }

    // Listener untuk pagination
    void onScroll() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (controller.hasMore.value) {
          controller.loadMoreList();
        }
      }
    }

    // Menambahkan listener scroll
    scrollController.addListener(onScroll);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
        Get.offAllNamed('/beranda');
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: const Text(
            'Data Absensi',
            style: TextStyle(color: bgColor),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: bgColor,
            ),
            onPressed: () {
              Get.offAllNamed('/beranda');
            },
          ),
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
                  return _buildListTile(item);
                } else {
                  return _buildLoadingIndicator();
                }
              },
            );
          }),
        ),
      ),
    );
  }

  Widget _buildListTile(var item) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(255, 209, 209, 209)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(item.user?.name ?? 'No Name'),
              IconButton(
                onPressed: () => _showDetails(item),
                icon: const Icon(Icons.info_outline, color: primaryColor),
              ),
            ],
          ),
          subtitle: _buildSubtitle(item),
        ),
      ),
    );
  }

  Widget _buildSubtitle(var item) {
    return Column(
      children: [
        _buildInfoRow('NIK', item.user?.nik ?? ''),
        _buildInfoRow('Tanggal', formatDate(item.date)),
        _buildInfoRow('Jam masuk', formatTimeSting(item.timeIn)),
        _buildInfoStatusRow('Status Jam masuk', item.statusIn ?? ''),
        _buildInfoRow('Jam pulang', formatTimeSting(item.timeOut)),
        _buildInfoStatusRow('Status Jam pulang', item.statusOut ?? ''),
      ],
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

  Widget _buildInfoStatusRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(
          value,
          style: TextStyle(color: value == 'late' ? dangerColor : primaryColor),
        ),
      ],
    );
  }

  Widget _buildLoadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(15),
      child: Center(
        child: CircularProgressIndicator(color: primaryColor),
      ),
    );
  }

  void _showDetails(var item) {
    Get.bottomSheet(
      Container(
        width: Get.width,
        height: Get.height / 3.2,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailHeader(),
              const Divider(),
              const SizedBox(height: 10),
              _buildInfoRow('NIK', item.user?.nik ?? ''),
              _buildInfoRow('Tanggal', formatDate(item.date)),
              _buildInfoRow('Jam masuk', formatTimeSting(item.timeIn)),
              _buildInfoStatusRow('Status Jam masuk', item.statusIn ?? ''),
              _buildInfoRow('Jam pulang', formatTimeSting(item.timeOut)),
              _buildInfoStatusRow('Status Jam pulang', item.statusOut ?? ''),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildDetailHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Detail Absen',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.close_outlined),
        ),
      ],
    );
  }
}
