import 'package:esas/constant.dart';
import 'package:flutter/material.dart';

Widget buildInfoRowApprove(String label, String value) {
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
