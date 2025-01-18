import 'package:esas/support/support.dart';
import 'package:flutter/material.dart';

Widget buildSubtitleRow(String label, String value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        label,
        style:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
      ),
      Text(limitString(value, 20)),
    ],
  );
}
