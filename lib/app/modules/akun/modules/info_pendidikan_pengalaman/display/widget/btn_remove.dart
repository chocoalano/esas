import 'package:flutter/material.dart';
import 'package:esas/constant.dart';

class RemoveButton extends StatelessWidget {
  final VoidCallback onRemove;

  // Constructor
  const RemoveButton({super.key, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: onRemove,
          icon: const Icon(
            Icons.remove_circle_outline,
            color: dangerColor,
          ),
        ),
      ],
    );
  }
}
