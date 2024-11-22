import 'package:esas/components/BottomNavigation/bot_nav_view.dart';
import 'package:esas/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../controllers/karyawan_controller.dart';

class KaryawanView extends GetView<KaryawanController> {
  const KaryawanView({super.key});
  @override
  Widget build(BuildContext context) {
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
          title: Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 10),
            child: TextField(
              controller: controller.search,
              decoration: InputDecoration(
                hintText: 'Cari...',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
                hintStyle: const TextStyle(color: Colors.white60),
                fillColor: bgColor.withOpacity(0.1),
                filled: true,
                prefixIcon: const Icon(
                  Icons.search,
                  color: bgColor,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 1, // Adjust vertical padding to reduce height
                  horizontal: 1, // Optional: Adjust horizontal padding
                ),
              ),
              style: const TextStyle(color: bgColor),
              onChanged: (value) {
                controller.fetchUsers(value);
              },
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.clear,
                color: bgColor,
              ),
              onPressed: () {
                controller.clearSearch();
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.refresh,
                color: bgColor,
              ),
              onPressed: () {
                controller.fetchUsers(controller.search.text);
              },
            ),
          ],
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: controller.listKaryawan.length,
              itemBuilder: (context, index) {
                final user = controller.listKaryawan[index];
                String limitString(String text, int maxLength) {
                  if (text.length <= maxLength) return text;
                  return '${text.substring(0, maxLength)}...';
                }

                return ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey.shade200,
                    child: ClipOval(
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: Image.network(
                          user.image ?? '',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.error, color: Colors.grey);
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return const CircularProgressIndicator();
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    limitString(user.name!, 30),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black54),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildSubtitleRow(
                          'Jabatan', user.employe?.job?.name! ?? ''),
                      buildSubtitleRow('Telp/HP', user.phone!)
                    ],
                  ),
                  onTap: () => _showDetails(user),
                );
              },
            );
          }
        }),
        bottomNavigationBar: BotNavView(),
      ),
    );
  }

  Widget buildSubtitleRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
        Text(limitString(value, 20)),
      ],
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

  void _showDetails(var item) {
    Get.bottomSheet(
      Container(
        width: Get.width,
        height: Get.height / 2,
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
                    'Detail Karyawan',
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
              _buildInfoRow('NIP', item.nik ?? ''),
              _buildInfoRow('Nama', limitString(item.name ?? '', 30)),
              _buildInfoRow('Email', limitString(item.email ?? '', 30)),
              _buildInfoRow('Telepon/HP', limitString(item.phone ?? '', 30)),
              _buildInfoRow('Jenis Kelamin',
                  item.gender == 'm' ? 'Laki-laki' : 'Perempuan'),
              _buildInfoRow(
                  'Tempat lahir', limitString(item.placebirth ?? '', 30)),
              _buildInfoRow('Tanggal Lahir', formatDate(item.datebirth)),
              _buildInfoRow('Gol. Darah', item.blood.toUpperCase() ?? ''),
              _buildInfoRow('Agama', item.religion ?? ''),
              _buildInfoRow('Status pernikahan',
                  statusPernikahan(item.maritalStatus ?? '')),
              _buildInfoRow('Departemen', item.employe.org.name ?? ''),
              _buildInfoRow('Jabatan', item.employe.job.name ?? ''),
              _buildInfoRow('Level', item.employe.lvl.name ?? ''),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }
}
