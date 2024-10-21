import 'package:esas/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';

class Empcard extends StatelessWidget {
  const Empcard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey.shade200,
          child: Obx(
            () => (controller.img.value.isNotEmpty)
                ? CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey.shade200,
                    child: ClipOval(
                      child: Image.network(
                        '$baseUrlImg/${controller.img.value}',
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
                  )
                : const SizedBox(),
          ),
        ),
        const SizedBox(width: 20), // Smaller spacing
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => Text(
                    controller.nama.value,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  )),
              Obx(() => Text(
                    controller.jabatan.value,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
