import 'package:esas/app/models/Tools/bug_reports.dart';
import 'package:esas/components/widgets/subtitle_row_text.dart';
import 'package:esas/constant.dart';
import 'package:esas/support/support.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget listItem(BugReports data) {
  return ListTile(
    leading: CircleAvatar(
      radius: 30,
      backgroundColor: Colors.grey.shade200,
      child: ClipOval(
        child: SizedBox(
          height: 50,
          width: 50,
          child: Image.network(
            "$baseUrlApi/assets/${data.image}",
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.error, color: Colors.grey),
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    ),
    title: Text(
      limitString(data.title ?? '', 30),
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black54,
      ),
    ),
    subtitle: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSubtitleRow('Platform', data.platform ?? '...'),
        buildSubtitleRow('Keluhan', data.message ?? '...'),
      ],
    ),
    onTap: () =>
        Get.offAllNamed('/akun/info-report-bugs/show', arguments: data),
  );
}
