import 'package:flutter/material.dart';

class CheckedField extends StatelessWidget {
  final bool isChecked;
  final String label;
  final IconData icon;
  final ValueChanged<bool?> onChanged;

  // Constructor
  const CheckedField({
    super.key,
    required this.isChecked,
    required this.label,
    required this.icon,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: isChecked,
          onChanged: onChanged,
        ),
        Text(label),
        const SizedBox(width: 10),
        Icon(icon),
      ],
    );
  }
}
