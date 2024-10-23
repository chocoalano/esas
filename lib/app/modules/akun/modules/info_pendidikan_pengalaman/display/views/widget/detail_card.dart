import 'package:esas/constant.dart';
import 'package:flutter/material.dart';

import '../../controllers/models.dart';

class DetailCard {
  static Widget buildFormalEducationCard(FormalEducation education, int index) {
    return _buildDetailCard(
      title: 'Data Pendidikan ${index + 1}',
      details: [
        _DetailRow(title: 'Instansi', value: education.institution),
        _DetailRow(
            title: 'Tahun Masuk & Keluar',
            value: '${education.start} - ${education.finish}'),
        _DetailRow(title: 'Tingkatan', value: education.majors),
        _DetailRow(
            title: 'Apakah Lulus?',
            value: education.certification == 1 ? 'Ya' : 'Tidak'),
      ],
    );
  }

  static Widget buildInformalEducationCard(
      InformalEducation education, int index) {
    return _buildDetailCard(
      title: 'Data Pendidikan/Kursus ${index + 1}',
      details: [
        _DetailRow(title: 'Instansi', value: education.name),
        _DetailRow(
            title: 'Tahun masuk & keluar',
            value: '${education.start}-${education.finish}'),
        _DetailRow(title: 'Jenis', value: education.type),
        _DetailRow(title: 'Lama kursus', value: '${education.duration} bulan'),
        _DetailRow(
            title: 'Apakah lulus?',
            value: education.certification == true ? 'Ya' : 'Tidak'),
      ],
    );
  }

  static Widget buildWorkExperienceCard(WorkExperience experience, int index) {
    return _buildDetailCard(
      title: 'Data Pengalaman Kerja ${index + 1}',
      details: [
        _DetailRow(title: 'Instansi', value: experience.company),
        _DetailRow(title: 'Posisi', value: experience.position),
        _DetailRow(title: 'Sejak', value: experience.from),
        _DetailRow(title: 'Sampai', value: experience.to),
        _DetailRow(
            title: 'Lama Mengabdi',
            value: '${experience.lengthOfService} Thn/bln'),
      ],
    );
  }

  static Widget _buildDetailCard({
    required String title,
    required List<_DetailRow> details,
  }) {
    return Card(
      color: bgColor,
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const Divider(),
            const SizedBox(height: 8),
            ...details.map((detail) => detail.build()).toList(),
          ],
        ),
      ),
    );
  }
}

class _DetailRow {
  final String title;
  final String value;

  _DetailRow({required this.title, required this.value});

  Widget build() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value, style: const TextStyle(overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }
}
