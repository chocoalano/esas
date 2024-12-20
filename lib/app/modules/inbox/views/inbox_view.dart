import 'package:esas/app/modules/inbox/controllers/inbox_controller.dart';
import 'package:esas/app/modules/inbox/views/pages/persetujuan_list.dart';
import 'package:esas/components/BottomNavigation/bot_nav_view.dart';
import 'package:esas/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'pages/notification_list.dart';

class InboxView extends GetView<InboxController> {
  const InboxView({super.key});

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
          title: const Text(
            'Inbox',
            style: TextStyle(color: bgColor),
          ),
          centerTitle: true,
          bottom: TabBar(
            controller: controller.tabController,
            tabs: const [
              Tab(text: "Notifikasi"),
              Tab(text: "Butuh persetujuan"),
            ],
            labelColor: Colors.white, // Text color for selected tab
            unselectedLabelColor:
                Colors.white70, // Text color for unselected tabs
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold, // Add more styles if needed
            ),
            indicatorColor: Colors.white, // Color of the indicator
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TabBarView(
            controller: controller.tabController,
            children: const [
              NotificationList(),
              PersetujuanList(),
            ],
          ),
        ),
        bottomNavigationBar: BotNavView(),
      ),
    );
  }
}
