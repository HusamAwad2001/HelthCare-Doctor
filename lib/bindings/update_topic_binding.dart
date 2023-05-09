import 'package:get/get.dart';

import '../controllers/update_topic_controller.dart';

class UpdateTopicBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateTopicController>(() => UpdateTopicController());
  }
}
