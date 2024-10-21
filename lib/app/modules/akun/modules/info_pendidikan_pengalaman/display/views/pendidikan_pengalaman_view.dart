import 'package:esas/components/globat_appbar.dart';
import 'package:esas/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/akun_pendidikan_pengalaman_controller.dart';
import '../controllers/models.dart';

class PendidikanPengalamanView
    extends GetView<AkunPendidikanPengalamanController> {
  const PendidikanPengalamanView({super.key});

  @override
  Widget build(BuildContext context) {
    // Fetch profile data only once when the widget is first built
    controller.getProfile();

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
        Navigator.pop(context);
      },
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: GlobatAppbar(
          title: 'Info pendidikan & pengalaman',
          act: () => Get.offAllNamed('/akun'),
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSection(
                  title: 'Info pendidikan formal',
                  onTitleTap: () => controller.movePage('/pendidikan-formal'),
                  options: _buildEducationOptions(
                    controller.formalEducation,
                    _buildFormalEducationOption,
                    'Belum ada data pendidikan formal',
                  ),
                ),
                _buildSection(
                  title: 'Info pendidikan informal',
                  onTitleTap: () => controller.movePage('/pendidikan-informal'),
                  options: _buildEducationOptions(
                    controller.informalEducation,
                    _buildInformalEducationOption,
                    'Belum ada data pendidikan informal',
                  ),
                ),
                _buildSection(
                  title: 'Info pengalaman kerja',
                  onTitleTap: () => controller.movePage('/pengalaman-kerja'),
                  options: _buildEducationOptions(
                    controller.workExperience,
                    _buildWorkExperienceOption,
                    'Belum ada data pengalaman kerja',
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  /// Reusable function to build a section with a title and options
  Widget _buildSection({
    required String title,
    VoidCallback? onTitleTap,
    required List<Widget> options,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(title: title, onTap: onTitleTap),
        const SizedBox(height: 10),
        ...options,
        const SizedBox(height: 20),
      ],
    );
  }

  /// Widget for section title with optional onTap action
  Widget _buildSectionTitle({required String title, VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          if (onTap != null)
            IconButton(
                onPressed: onTap,
                icon: const Icon(Icons.edit_note, color: primaryColor))
        ],
      ),
    );
  }

  /// Widget to build education options, returning a list of widgets
  List<Widget> _buildEducationOptions<T>(
    List<T> educationList,
    Widget Function(T) builderFunction,
    String noDataMessage,
  ) {
    return educationList.isNotEmpty
        ? educationList.map(builderFunction).toList()
        : [_buildNoDataOption(noDataMessage)];
  }

  /// Widget to display formal education option
  Widget _buildFormalEducationOption(FormalEducation education) {
    return _buildDetailCard(
      title: 'Data Pendidikan',
      details: [
        _DetailRow(title: 'Instansi', value: education.institution),
        _DetailRow(
            title: 'Tahun masuk & keluar',
            value: '${education.start}-${education.finish}'),
        _DetailRow(title: 'Tingkatan', value: education.majors),
        _DetailRow(
            title: 'Apakah lulus?',
            value: education.certification == true ? 'Ya' : 'Tidak'),
      ],
    );
  }

  /// Widget to display informal education option
  Widget _buildInformalEducationOption(InformalEducation education) {
    return _buildDetailCard(
      title: 'Data Pendidikan/Kursus',
      details: [
        _DetailRow(title: 'Instansi', value: education.name),
        _DetailRow(
            title: 'Tahun masuk & keluar',
            value: '${education.start}-${education.finish}'),
        _DetailRow(title: 'Berlaku hingga?', value: education.expired),
        _DetailRow(title: 'Jenis', value: education.type),
        _DetailRow(title: 'Lama kursus', value: '${education.duration}'),
        _DetailRow(
            title: 'Biaya', value: formatRupiah(education.fee.toDouble())),
        _DetailRow(
            title: 'Apakah lulus?',
            value: education.certification == true ? 'Ya' : 'Tidak'),
      ],
    );
  }

  /// Widget to display work experience option
  Widget _buildWorkExperienceOption(WorkExperience experience) {
    return _buildDetailCard(
      title: 'Data Pengalaman kerja',
      details: [
        _DetailRow(title: 'Instansi', value: experience.company),
        _DetailRow(title: 'Posisi', value: experience.position),
        _DetailRow(title: 'Sejak', value: experience.from),
        _DetailRow(title: 'Sampai', value: experience.to),
        _DetailRow(
            title: 'Lama mengabdi',
            value: '${experience.lengthOfService} Thn/bln'),
      ],
    );
  }

  /// Widget reusable for every option in a section
  Widget _buildOption(IconData icon, String text, VoidCallback? onTap) {
    return Card(
      color: bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      elevation: 0,
      child: ListTile(
        leading: Icon(icon, color: Colors.black54),
        title: Text(
          text,
          style: const TextStyle(fontSize: 16, fontFamily: 'PlusJakartaSans'),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  /// Widget for displaying no data message
  Widget _buildNoDataOption(String message) {
    return _buildOption(
      Icons.info_outline,
      message,
      null,
    );
  }

  /// Widget for building a detailed information card
  Widget _buildDetailCard(
      {required String title, required List<_DetailRow> details}) {
    return Card(
      color: bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const Divider(),
            const SizedBox(height: 8),
            ...details.map((detail) => detail.build()),
          ],
        ),
      ),
    );
  }

  String formatRupiah(double amount) {
    final NumberFormat formatter = NumberFormat.currency(
      locale: 'id_ID', // Locale untuk Indonesia
      symbol: 'Rp', // Simbol mata uang
      decimalDigits: 0, // Jumlah digit desimal
    );
    return formatter.format(amount);
  }
}

/// Helper class to represent a detail row
class _DetailRow {
  final String title;
  final String value;

  _DetailRow({required this.title, required this.value});

  Widget build() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(value),
      ],
    );
  }
}
