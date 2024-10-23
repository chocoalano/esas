import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlertBanner extends StatelessWidget {
  const AlertBanner({
    super.key,
    required this.act,
    required this.color,
    required this.msg,
    required this.show,
  });

  final String msg;
  final VoidCallback act;
  final Color color;
  final RxBool show;

  @override
  Widget build(BuildContext context) {
    return Obx(() => show.isTrue
        ? MaterialBanner(
            elevation: 0,
            padding: const EdgeInsets.all(10),
            content: Text(
              msg,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            backgroundColor: color,
            actions: [
              IconButton(
                onPressed: act,
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              )
            ],
          )
        : const SizedBox.shrink());
  }
}
