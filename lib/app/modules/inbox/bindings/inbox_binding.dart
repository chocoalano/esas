import 'package:get/get.dart';

import '../controllers/inbox_controller.dart';
import '../controllers/notification_list_controller.dart';
import '../controllers/persetujuan_controller.dart';

class InboxBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InboxController>(
      () => InboxController(),
    );
    Get.lazyPut<PersetujuanController>(
      () => PersetujuanController(),
    );
    Get.lazyPut<NotificationListController>(
      () => NotificationListController(),
    );
  }
}
